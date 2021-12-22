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
        .on(Razorpay.EVENT_PAYMENT_SUCCESS, RP().handlePaymentSuccess);
    _razorpay.razorpay
        .on(Razorpay.EVENT_PAYMENT_ERROR, RP().handlePaymentError);
    _razorpay.razorpay
        .on(Razorpay.EVENT_EXTERNAL_WALLET, RP().handleExternalWallet);
    RPpost? order;
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
                Expanded(
                    flex: 1,
                    child: !Provider.of<BoolChange>(context).isReady
                        ? Column(
                            children: [
                              ElevatedButton(
                                child: Text('RP'),
                                onPressed: () async {
                                  // order = await RazorPayCreateOrder()
                                  //     .createOrder(
                                  //         name: 'Test',
                                  //         email: 'test@gmail.om',
                                  //         phone: '8210375471',
                                  //         receipt: '3475');
                                  // Provider.of<RPpost>(context, listen: false)
                                  //     .setOrderId = order!.orderId;
                                  // Provider.of<BoolChange>(context,
                                  //         listen: false)
                                  //     .ready();
                                  _razorpay.checkout('Test', '9811130906',
                                      'test@gmail.om', 'order_Ia7ItJ1ttRmp7M');
                                },
                              ),
                            ],
                          )
                        : Center(
                            child: Text(
                                Provider.of<RPpost>(context).orderId ?? 'err'),
                          )),
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
                            int rounded, invested;
                            if (amount < 100) {
                              if (amount % 5 == 0) {
                                invested = 5;
                              } else {
                                rounded = (amount / 5).ceil() * 5;
                                invested = rounded - amount;
                              }
                            } else {
                              if (amount % 10 == 0) {
                                invested = 10;
                              } else {
                                rounded = (amount / 10).ceil() * 10;
                                invested = rounded - amount;
                              }
                            }
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
