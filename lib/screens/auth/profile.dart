import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late RP _razorpay;
  String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
  Db db = Db();
  bool sbool = true;

  void _signOut() {
    FirebaseAuth.instance.signOut();
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
    return Scaffold(
      backgroundColor: Color(0xff473270),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 60.0,
                width: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/getsurge.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Crypto & You',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[600],
            radius: 40,
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: db.name,
              builder: (context, snapshot) {
                return RichText(
                  text: TextSpan(
                    text: "Hi, " + snapshot.data.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: db.email,
              builder: (context, snapshot) {
                return RichText(
                  text: TextSpan(
                    text: snapshot.data.toString(),
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 20,
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Container(
          //     alignment: Alignment.bottomLeft,
          //     child: Text(
          //       'Transactions',
          //       textAlign: TextAlign.start,
          //       style: TextStyle(
          //           color: Color(0xffD19549),
          //           fontSize: 20,
          //           fontWeight: FontWeight.w800),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                  msg: "Feature Not Supported",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red.shade400,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Card(
              color: Color(0xff2C9479),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.monetization_on_rounded,
                      size: 25,
                      color: Color(0xffE4A951),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto Invest ₹10',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'When no spends detected',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Spacer(),
                    Switch(
                        activeColor: Colors.deepPurple,
                        value: sbool,
                        onChanged: (bool sb) {
                          setState(() {
                            sbool = true;
                            print(sbool);
                          });
                        }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
            label: Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              elevation: 10,
              primary: Color(0xffD19549),
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
            ),
          ),
          // ElevatedButton(
          //   onPressed: _signOut,
          //   child: Text(
          //     'Logout',
          //     style: TextStyle(
          //       color: Color(0xff464646),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20,
          //     ),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     shape: new RoundedRectangleBorder(
          //       borderRadius: new BorderRadius.circular(20.0),
          //     ),
          //     elevation: 10,
          //     primary: Color(0xffD19549),
          //     padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          //   ),
          // ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  child: FaIcon(FontAwesomeIcons.whatsapp,
                      color: Colors.white, size: 30),
                  backgroundColor: Color(0xff00E676),
                  foregroundColor: Colors.white,
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
