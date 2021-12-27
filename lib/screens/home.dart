import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          backgroundColor: Color.fromRGBO(30, 27, 44, 0),
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
                          fontFamily: 'IslandMoments',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                  child: Card(
                    color: Color.fromRGBO(90, 20, 190, 2),
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
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
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
                                      Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 9,
                                              bottom: 13,
                                              left: 10,
                                              right: 10),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.security,
                                                color: Colors.black,
                                                size: 65,
                                              ),
                                              Text('100% Secure',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 9,
                                              bottom: 10,
                                              left: 13,
                                              right: 13),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.change_circle_outlined,
                                                color: Colors.black,
                                                size: 60,
                                              ),
                                              Text('Spare Change',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('Auto Invested',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.grey[400],
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 9,
                                              bottom: 10,
                                              left: 13,
                                              right: 13),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.maps_home_work_sharp,
                                                color: Colors.black,
                                                size: 60,
                                              ),
                                              Text('Support 13+',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('Banks',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 15, left: 13, right: 13),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var cust = await RazorPayAPIpost()
                                          .createCustomer(await db.name, phone,
                                              await db.email);
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
                                    child: Text('Setup Auto Pay'),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                      primary: Colors.purple[900],
                                      padding: EdgeInsets.only(
                                          left: 100,
                                          right: 100,
                                          top: 15,
                                          bottom: 15),
                                    ),
                                  ),
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
                ),
                Text(
                  'Recent Transactions ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder(
                  stream: Db().listenToMessages,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('data');
                    } else {
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
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
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10.0,
                                    right: 10.0,
                                    left: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      'You spent ₹' + amount.toString(),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    subtitle: Text(
                                        date.toString() + " " + tim.toString()),
                                    trailing: Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Invested ₹" + invested.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
