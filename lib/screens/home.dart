import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testings/main.dart';
import 'package:testings/models/change.dart';
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
        backgroundColor: Color(0xff0473270),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.green,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, top: 100, right: 12),
              child: SizedBox(
                height: 210,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: db.listenToDb,
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        FaIcon(
                                          FontAwesomeIcons.creditCard,
                                          size: 30,
                                          color: Color(0xffD19549),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '${snapshot.data!['amount'] ?? '0'} BTC',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 5,
                    color: Color(0xff5C4A7F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: db.listenToDb,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (!snapshot.data!['rp_authorized']) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text('Setup Auto-Invest',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Color(0xffB48861),
                                            child: Icon(
                                              Icons.security,
                                              size: 45,
                                              color: Color(0xff473270),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text('100% Secure',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 5),
                                          Text('',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Color(0xffB48861),
                                            child: Icon(
                                              Icons.change_circle_outlined,
                                              size: 45,
                                              color: Color(0xff473270),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text('Spare charge',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text('auto-invested',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Color(0xffB48861),
                                            child: Icon(
                                              Icons.maps_home_work_sharp,
                                              size: 45,
                                              color: Color(0xff473270),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text('Support 13+',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          Text('Banks',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var cust = await RazorPayAPIpost()
                                          .createCustomer(await db.name, phone,
                                              await db.email);
                                      Db().addCustomerId(cust.custId!);
                                      var order = await RazorPayAPIpost()
                                          .createAuthOrder(cust.custId!);
                                      print(order.orderId);
                                      _razorpay.checkout(
                                          await db.name,
                                          phone,
                                          await db.email,
                                          order.orderId!,
                                          cust.custId!);
                                    },
                                    child: Text('Setup Auto-Pay',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                    style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                      elevation: 20,
                                      primary: Color(0xffBD8753),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 90, vertical: 15),
                                    ),
                                  ),
                                )
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
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Center(
              child: Text(
                'Recent Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 380),
              child: StreamBuilder(
                stream: Db().listenToMessages,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('data');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length>5 ?5:snapshot.data!.docs.length,
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
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff555555),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Spent ₹' + amount.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  date.toString() + " " + tim.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Container(
                                  height: 35,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Color(0xff141414),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Invested ₹" + invested.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xff14EE80),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
