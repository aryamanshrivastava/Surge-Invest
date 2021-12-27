import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen(this.phone);

  final String? phone;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

const themeColor = const Color(0xff063970);

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(30, 27, 44, 0),
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 80,left: 40),
              child: Row(
                children: [
                  RichText(
                            text: TextSpan(
                              text: "Let's ",
                              style: TextStyle(
                                fontFamily: 'IslandMoments',
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'SURGE',
                              style: TextStyle(
                                fontFamily: 'IslandMoments',
                                  fontSize: 48,
                                  color: Colors.yellowAccent,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                style: TextStyle(
                  //letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Name',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black26),
                    //border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                  //letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                    hintText: 'Email Id',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black26),
                    //border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phController,
                style: TextStyle(
                  //letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                    hintText: 'Phone No.',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black26),
                    //border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpScreen(
                              phoneNumber: phController.text,
                              name: nameController.text,
                              email: emailController.text,
                              registered: false,
                              auth: _auth,
                            )));
              },
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[900],
                    padding: EdgeInsets.only(
                        left: 100, right: 100, top: 15, bottom: 15),
                  ),
            ),
          ],
        ),
      )),
    );
  }
}
