import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testings/main.dart';
import 'package:testings/models/change.dart';
// ignore: unused_import
import 'package:testings/models/razorpay.dart';
import 'package:testings/services/db.dart';
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
  // ignore: unused_field
  final Stream _usersStream =
      FirebaseFirestore.instance.collection('users').doc().snapshots();

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
          backgroundColor: Colors.deepPurple,
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 25),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/w3images/avatar2.png'),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(right: 170, bottom: 10),
                //   child: IconButton(
                //     iconSize: 20,
                //     icon: Icon(Icons.border_color),
                //     color: Colors.white,
                //     onPressed: () {},
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 200, top: 10),
                  child: RichText(
                    text: TextSpan(
                      text: 'Hi,Invester',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                  child: Card(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: db.listenToDb,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 50, top: 50, right: 100, left: 100),
                            child: Text(
                              'Invested ${snapshot.data!['amount'] ?? '0'} BTC',
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                Card(
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
                // Text(
                //   'Recent Transactions ',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // StreamBuilder(
                //   stream: Db().listenToMessages,
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (!snapshot.hasData) {
                //       return Text('data');
                //     } else {
                //       return Expanded(
                //         //flex: 1,
                //         child: Padding(
                //           padding: const EdgeInsets.all(2.0),
                //           child: ListView.builder(
                //             itemCount: snapshot.data!.docs.length,
                //             itemBuilder: (context, index) {
                //               var doc = snapshot.data!.docs[index];
                //               Timestamp time = doc['time'];
                //               var parsedDT = time.toDate();
                //               var date = DateFormat.yMMMd().format(parsedDT);
                //               var tim = DateFormat.jm().format(parsedDT);
                //               int amount = doc['amount'];
                //               int rounded, invested;
                //               if (amount < 100) {
                //                 if (amount % 5 == 0) {
                //                   invested = 5;
                //                 } else {
                //                   rounded = (amount / 5).ceil() * 5;
                //                   invested = rounded - amount;
                //                 }
                //               } else {
                //                 if (amount % 10 == 0) {
                //                   invested = 10;
                //                 } else {
                //                   rounded = (amount / 10).ceil() * 10;
                //                   invested = rounded - amount;
                //                 }
                //               }
                //               return Padding(
                //                 padding: const EdgeInsets.only(
                //                     top: 10,
                //                     bottom: 10.0,
                //                     right: 1.0,
                //                     left: 1.0),
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(20),
                //                     color: Colors.white,
                //                   ),
                //                   child: ListTile(
                //                     title: Text(
                //                       'You spent ₹' + amount.toString(),
                //                       style: TextStyle(fontSize: 20.0),
                //                     ),
                //                     subtitle: Text(
                //                         date.toString() + " " + tim.toString()),
                //                     trailing: Text(
                //                       "Invested ₹" + invested.toString(),
                //                       style: TextStyle(fontSize: 18.0),
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       );
                //     }
                //   },
                // )
              ],
            ),
          )),
    );
  }
}
