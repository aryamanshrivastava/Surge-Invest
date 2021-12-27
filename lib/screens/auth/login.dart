import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/messaging.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

const themeColor = const Color(0xff063970);

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final _auth = AuthService();

  @override
  void initState() {
    MessagingService().getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff272239),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 80, left: 40),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Let's ",
                        style: TextStyle(
                          //fontFamily: 'IslandMoments',
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    RichText(
                      text: TextSpan( 
                        text: 'SURGE',
                        style: TextStyle(
                          //fontFamily: 'IslandMoments',
                            fontSize: 48,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  style: TextStyle(
                    //letterSpacing: 2,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Phone No.',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black26),
                      //border: InputBorder.none,
                      counterText: ''),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var doc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc('+91' + phoneController.text)
                      .get();
                  if (doc.exists) {
                    _auth.logInWIthPhone(phone: phoneController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  phoneNumber: phoneController.text,
                                  registered: true,
                                  auth: _auth,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(phoneController.text)));
                  }
                },
                child: Text(
                  'Enter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  primary: Colors.purple[900],
                  padding: EdgeInsets.only(
                      left: 130, right: 130, top: 15, bottom: 15),
                ),
              ),
            ],
          )),
    ));
  }
}
