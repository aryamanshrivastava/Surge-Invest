import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testings/main.dart';
import 'package:testings/models/change.dart';
import 'package:testings/models/razorpay.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/helpers.dart';
import 'package:testings/services/messaging.dart';
import 'package:testings/services/razorpay.dart';
import 'package:testings/services/razorpay_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final telephony = Telephony.instance;
  final ready = BoolChange();
  late RP _razorpay;
  String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
  Db db = Db();
  final Stream _usersStream =
      FirebaseFirestore.instance.collection('users').doc().snapshots();

  // bool _isOrderReady = false;

  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: MessagingService().incomingMessageHandler,
      onBackgroundMessage: backgroundMessageHandler,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _razorpay = Provider.of<RP>(context);
    _razorpay.razorpay
        .on(Razorpay.EVENT_PAYMENT_SUCCESS, RP(context).handlePaymentSuccess);
    _razorpay.razorpay
        .on(Razorpay.EVENT_PAYMENT_ERROR, RP(context).handlePaymentError);
    _razorpay.razorpay
        .on(Razorpay.EVENT_EXTERNAL_WALLET, RP(context).handleExternalWallet);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Surge'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: db.listenToDb,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                                'Invested ${snapshot.data!['amount'] ?? '0'} BTC');
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: db.listenToDb,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (!snapshot.data!['rp_authorized']) {
                          return Column(
                            children: [
                              ElevatedButton(
                                child: Text('RP'),
                                onPressed: () async {
                                  var cust = await RazorPayAPIpost()
                                      .createCustomer(
                                          await db.name, phone, await db.email);
                                  Db().addCustomerId(cust.custId!);
                                  var order = await RazorPayAPIpost()
                                      .createAuthOrder(cust.custId!, '1');
                                  print(order.orderId);

                                  _razorpay.checkout(
                                      await db.name,
                                      phone,
                                      await db.email,
                                      order.orderId!,
                                      cust.custId!);
                                },
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
                Text(
                  'Recent Transactions ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: Db().listenToMessages,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('data');
                    } else {
                      return Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            Timestamp time = doc['time'];
                            var parsedDT = time.toDate();
                            var date = DateFormat.yMMMd().format(parsedDT);
                            var tim = DateFormat.jm().format(parsedDT);
                            int amount = doc['amount'];

                            int invested = Helpers().invested(amount);
                            return ListTile(
                              title: Text('You spent ₹' + amount.toString()),
                              subtitle:
                                  Text(date.toString() + " " + tim.toString()),
                              trailing:
                                  Text("Invested ₹" + invested.toString()),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
