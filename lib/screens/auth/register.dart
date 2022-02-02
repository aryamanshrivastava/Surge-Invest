import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen(this.phoneController);

  final TextEditingController phoneController;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

const themeColor = const Color(0xff063970);

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0473270),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(phoneController)));
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
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 250.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/app.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              'Hello New User!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: nameController,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    fillColor: Color(0xff0503971),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Name',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Color(0xffD19549),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white70)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    fillColor: Color(0xff0503971),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Email Id',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xffD19549),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white70)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: widget.phoneController,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xff0503971),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreen(
                                phoneNumber: widget.phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                registered: false,
                                auth: _auth,
                              )));
                },
                child: Text(
                  'Register!',
                  style: TextStyle(
                    color: Color(0xff464646),
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
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
              ),
            )
          ]),
        ),
      ),
    );
  }
}
          // backgroundColor: Color(0xff0D104E),
          // body: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       // Padding(
          //       //   padding: const EdgeInsets.only(bottom: 70),
          //       //   child:
          //       Container(
          //         width: MediaQuery.of(context).size.width / 2,
          //         height: MediaQuery.of(context).size.height / 5,
          //         child: FittedBox(
          //           child: Text(
          //             'Register',
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 //fontSize: 50,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ),
          //       ),
                
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: TextField(
          //           controller: nameController,
          //           style: TextStyle(
          //             fontSize: 20,
          //           ),
          //           decoration: InputDecoration(
          //               fillColor: Colors.white,
          //               filled: true,
          //               enabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(Radius.circular(10)),
          //                   borderSide: BorderSide(
          //                       color: Colors.deepPurple, width: 3.0)),
          //               hintText: 'Name',
          //               prefixIcon: const Icon(
          //                 Icons.person,
          //                 color: Colors.purpleAccent,
          //               ),
          //               hintStyle: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 20,
          //                   color: Colors.black26),
          //               counterText: ''),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: TextField(
          //           controller: emailController,
          //           style: TextStyle(
          //             fontSize: 20,
          //           ),
          //           decoration: InputDecoration(
          //               fillColor: Colors.white,
          //               filled: true,
          //               enabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(Radius.circular(10)),
          //                   borderSide: BorderSide(
          //                       color: Colors.deepPurple, width: 3.0)),
          //               hintText: 'Email Id',
          //               prefixIcon: const Icon(
          //                 Icons.email,
          //                 color: Colors.purpleAccent,
          //               ),
          //               hintStyle: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 20,
          //                   color: Colors.black26),
          //               counterText: ''),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: TextField(
          //           keyboardType: TextInputType.number,
          //           controller: widget.phoneController,
          //           style: TextStyle(
          //             fontSize: 20,
          //           ),
          //           decoration: InputDecoration(
          //               fillColor: Colors.white,
          //               filled: true,
          //               enabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(Radius.circular(10)),
          //                   borderSide: BorderSide(
          //                       color: Colors.deepPurple, width: 3.0)),
          //               hintText: 'Phone No.',
          //               prefixIcon: const Icon(
          //                 Icons.call,
          //                 color: Colors.purpleAccent,
          //               ),
          //               hintStyle: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 20,
          //                   color: Colors.black26),
          //               counterText: ''),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(15.0),
          //         child: ElevatedButton(
          //           onPressed: () async {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => OtpScreen(
          //                           phoneNumber: widget.phoneController.text,
          //                           name: nameController.text,
          //                           email: emailController.text,
          //                           registered: false,
          //                           auth: _auth,
          //                         )));
          //           },
          //           child: Center(
          //             child: Container(
          //               width: MediaQuery.of(context).size.width / 3,
          //               child: FittedBox(
          //                 child: Text(
          //                   'Create Account',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     //fontSize: 22.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           style: ElevatedButton.styleFrom(
          //             elevation: 50,
          //             primary: Color(0xff8A00FF),
          //             padding: EdgeInsets.symmetric(vertical: 15),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )

