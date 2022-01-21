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
    //Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff0D104E),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.only(bottom: 70),
              //   child:
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 5,
                child: FittedBox(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        //fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // child: RichText(
              //   text: TextSpan(
              //     text: "Welcome",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 50,
              //         fontWeight: FontWeight.w700),
              //   ),
              // ),
              //),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 3.0)),
                      hintText: 'Phone No.',
                      prefixIcon: const Icon(
                        Icons.call,
                        color: Colors.purpleAccent,
                      ),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black26),
                      counterText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
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
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 7,
                      child: FittedBox(
                        child: Text(
                          'Enter',
                          style: TextStyle(
                            color: Colors.white,
                            //fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 50,
                    primary: Color(0xff8A00FF),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}