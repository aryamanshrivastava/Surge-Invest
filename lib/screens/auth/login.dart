import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/screens/auth/register.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/messaging.dart';

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
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: phoneController,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    hintText: 'Phone no.',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                    border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            SizedBox(
              height: 30,
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
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterScreen(phoneController.text)),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
