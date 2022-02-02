import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      updateMessages();
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
      backgroundColor: Color(0xff0D104E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, top: 5, right: 12),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.orange, width: 3.0),
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xff000000).withOpacity(0.1),
              child: StreamBuilder<DocumentSnapshot>(
                stream: db.listenToDb,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      heightFactor: 5,
                      child: Text(
                        '${snapshot.data!['amount'] ?? '0'} BTC',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold),
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
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              elevation: 5,
              color: Color(0xff000000).withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.purpleAccent, width: 2.5),
                  borderRadius: BorderRadius.circular(20)),
              child: StreamBuilder<DocumentSnapshot>(
                stream: db.listenToDb,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Color(0xff0D104E),
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
                                          color: Colors.white70,
                                          size: 65,
                                        ),
                                        Text('100% Secure',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Color(0xff0D104E),
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
                                          color: Colors.white70,
                                          size: 60,
                                        ),
                                        Text('Spare Change',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        Text('Auto Invested',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Color(0xff0D104E),
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
                                          color: Colors.white70,
                                          size: 60,
                                        ),
                                        Text('Support 13+',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        Text('Banks',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                var cust = await RazorPayAPIpost()
                                    .createCustomer(
                                        await db.name, phone, await db.email);
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
                              child: Text(
                                'Setup Auto-Pay',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.5, 0.5),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 20,
                                primary: Color(0xff8A00FF),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 90, vertical: 15),
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
          SizedBox(
            height: 10,
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
                      itemCount: snapshot.data!.docs.length > 5
                          ? 5
                          : snapshot.data!.docs.length,
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
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff000000).withOpacity(0.1),
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
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Invested ₹" + invested.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
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
    ));
  }

  updateMessages() async {
    final prefs = await SharedPreferences.getInstance();
    int timeStamp = prefs.getInt('timestamp')?? DateTime.now().millisecondsSinceEpoch;
    List<SmsMessage> messages = await telephony.getInboxSms(
        columns: [SmsColumn.BODY, SmsColumn.DATE],
        filter: SmsFilter.where(SmsColumn.DATE).greaterThanOrEqualTo(timeStamp.toString()),
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)]
    );
    for(var i in messages){
      if (i.body.toString().contains(new RegExp(r'([Rr]s\.?)')) &&
          i.body.toString().contains(new RegExp(r'([Ss]ent)|([Pp]aid)|([Dd]ebited)|DEBITED')) &&
          !(i.body.toString().contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)|[Rr]azorpay|[Uu]nsuccessful|[Pp]ending')))){
        if (RegExp(r'(?<=([Rr]s)\.* *)[0-9]*')
            .firstMatch(i.body.toString())
            ?.group(0) !=
            null) {
          String? temp = RegExp(r'(?<=([Rr]s))\.? ?[0-9]*')
              .firstMatch(i.body.toString())
              ?.group(0);
          if (temp![0] == ' ' || temp[0] == '.') {
            temp = temp.substring(1);
          }
          int amount = int.parse(temp);
          if (amount > 10) {
            print(amount);
            print(i.date);
            FirebaseFirestore.instance.collection('users')
                .doc(FirebaseAuth.instance.currentUser!.phoneNumber!)
                .collection('messages')
                .doc()
                .set({
              'amount': amount,
              'time': DateTime.fromMicrosecondsSinceEpoch(i.date!)
            });
          }
        }
      }
    }
    prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
  }

}
