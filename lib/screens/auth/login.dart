import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/messaging.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(TextEditingController phoneController);

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
      backgroundColor: Color(0xff0473270),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterScreen(phoneController)));
                },
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color(0xff0503971),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 30,
                        color: Color(0xffD19549),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 100.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/getsurge.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xff0503971),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Phone No.',
                  prefixIcon: const Icon(
                    Icons.call_outlined,
                    color: Color(0xffD19549),
                  ),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white70),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                              RegisterScreen(phoneController)));
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xff464646),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                elevation: 10,
                primary: Color(0xffD19549),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
