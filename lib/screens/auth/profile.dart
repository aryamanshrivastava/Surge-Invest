import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay.dart';
import 'package:testings/services/razorpay_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late RP _razorpay;
  String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
  Db db = Db();
  bool sbool = false;

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
            height: 20,
          ),
          CircleAvatar(
            radius: 46,
            backgroundImage:
                NetworkImage('https://www.w3schools.com/w3images/avatar2.png'),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Hi Investor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // SizedBox(
          //   height: 30,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     print('Hello');
          //   },
          //   child: Card(
          //     color: Color(0xff543A6D),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)),
          //     margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           Icon(
          //             Icons.edit,
          //             size: 25,
          //             color: Color(0xffB07C52),
          //           ),
          //           SizedBox(
          //             width: 20,
          //           ),
          //           Text(
          //             'Edit Profile',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.w800),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 30,
          // ),
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
          // Card(
          //   color: Color(0xff2C9479),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Icon(
          //           Icons.monetization_on_rounded,
          //           size: 25,
          //           color: Color(0xffE4A951),
          //         ),
          //         SizedBox(
          //           width: 20,
          //         ),
          //         Text(
          //           'Auto Invest ₹',
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         Spacer(),
          //         Switch(
          //             value: sbool,
          //             onChanged: (bool sb) {
          //               setState(() {
          //                 sbool = sb;
          //                 print(sbool);
          //               });
          //             }),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // GestureDetector(
          //   onTap: () async {
          //     var cust = await RazorPayAPIpost()
          //         .createCustomer(await db.name, phone, await db.email);
          //     Db().addCustomerId(cust.custId!);
          //     var order = await RazorPayAPIpost().createAuthOrder(cust.custId!);
          //     print(order.orderId);
          //     _razorpay.checkout(await db.name, phone, await db.email,
          //         order.orderId!, cust.custId!);
          //   },
          //   child: Card(
          //     color: Color(0xff2C9479),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)),
          //     margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           Icon(
          //             Icons.payment,
          //             size: 25,
          //             color: Color(0xffE4A951),
          //           ),
          //           SizedBox(
          //             width: 20,
          //           ),
          //           Text(
          //             'Auto-Pay',
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 20,
          //                 fontWeight: FontWeight.w800),
          //           ),
          //           Spacer(),
          //           Icon(
          //             Icons.arrow_right,
          //             size: 25,
          //             color: Colors.black,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 40),
          ElevatedButton.icon(
              onPressed: _signOut,
              icon: Icon(Icons.logout),
              label: Text('Logout', style: TextStyle(fontWeight: FontWeight.w800),),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              elevation: 10,
              primary: Color(0xffD19549),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
