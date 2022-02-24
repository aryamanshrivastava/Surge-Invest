import 'dart:async';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/db.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.phoneNumber,
    this.name,
    this.email,
    required this.registered,
    required this.auth,
    Key? key,
  }) : super(key: key);

  final String? phoneNumber;
  final String? name;
  final String? email;
  final bool? registered;
  final AuthService? auth;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? sentCode;
  String? enteredOTP = '';
  int start = 30;
  bool wait = true;
  String buttonName = "Send";
  // final _auth = AuthService();
  @override
  void initState() {
    widget.auth!.logInWIthPhone(phone: widget.phoneNumber!);
    startTimer();
    wait = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff0473270),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Color(0xff0503971),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    )
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                  color: Color(0xffD19549),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff5A406A),
                        child: Icon(
                          Icons.message_outlined,
                          size: 30,
                          color: Color(0xffE4A951),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Please enter the OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'sent on +91 ${widget.phoneNumber}',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(120.0),
                          ),
                          color: Color(0xff9E6D60)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 90),
                              child: OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width*0.9,
                                fieldWidth: MediaQuery.of(context).size.width*0.1,
                                otpFieldStyle: OtpFieldStyle(
                                  backgroundColor: Color(0xff775367),
                                  borderColor: Color(0xff0473270),
                                  enabledBorderColor: Color(0xff452ac6),
                                  focusBorderColor: Color(0xff452ac6),
                                ),
                                style: TextStyle(fontSize: 17, color: Colors.white),
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.box,
                                onCompleted: (pin) {
                                  enteredOTP = pin;
                                },
                                onChanged: (pin) {},
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (enteredOTP!.length < 6) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text('Invalid OTP'),
                                        );
                                      });
                                } else {
                                  widget.auth!.verifyOtp(enteredOTP!, context);
                                  if (!widget.registered!) {
                                    Db().addUser(
                                      widget.email!,
                                      widget.name!,
                                      widget.phoneNumber!,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'VERIFY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20.0),
                                  ),
                                  primary: Color(0xff5C4175),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 90, vertical: 15)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: wait
                                  ? null
                                  : () async {
                                      widget.auth!.logInWIthPhone(
                                          phone: widget.phoneNumber!);
                                      setState(() {
                                        startTimer();
                                        start = 30;
                                        wait = true;
                                      });
                                    },
                              child: RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Didn't receive OTP? Resend",
                                    style: TextStyle(
                                        fontSize: 13, color: wait? Colors.grey:Colors.white),
                                  ),
                                  TextSpan(
                                    text: wait ? " in ${start}s" : "",
                                    style: TextStyle(
                                        fontSize: 13, color: wait? Colors.grey:Colors.white),
                                  ),
                                ],
                              )),
                              style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                  ),
                                  primary: Color(0xff5C4175),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3)),
                            ),

                            // TextButton(
                            //   onPressed: wait ? null : () async {
                            //     setState(() {
                            //       startTimer();
                            //       start = 30;
                            //       wait = true;
                            //     });
                            //
                            //   },
                            //   child: Text(
                            //     'Resend',
                            //     style: TextStyle(
                            //       color: wait ? Colors.white :Color(0xff5C4175),
                            //       fontSize: 20.0,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            //
                            // )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
