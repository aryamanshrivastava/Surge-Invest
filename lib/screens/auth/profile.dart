import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                height: 80.0,
                width: 180.0,
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
                    fontSize: 18,
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
                        fontFamily: 'Poppins',
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
                      fontFamily: 'Poppins',
                      color: Colors.white30,
                      fontSize: 20,
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white30,
                fontSize: 20,
              ),
            ),
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
                    onPressed: () async {
                      String phoneNumber = '+919652354388';
                      var url =
                          'https://wa.me/$phoneNumber?text=Hi%20Surge!%20';
                      await launch(url);
                    }),
              ], 
            ),
          ),
        ],
      ),
    );
  }
}
