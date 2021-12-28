import 'package:flutter/material.dart';
import 'package:testings/services/auth.dart';
import 'package:otp_text_field/otp_field.dart';
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
  final _auth = AuthService();

  @override
  void initState() {
    widget.auth!.logInWIthPhone(phone: widget.phoneNumber!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff272239),
          body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 350, bottom: 120),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Verify Phone No.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Code is sent to ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: OTPTextField(
                    //otpFieldStyle: ,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 16,
                    style: TextStyle(fontSize: 20,color: Colors.white),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onCompleted: (pin) {
                      enteredOTP = pin;
                    },
                    onChanged: (pin) {},
                  ),
                ),
                SizedBox(
                  height: 20,
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
                    primary: Colors.purple[900],
                    padding: EdgeInsets.only(
                        left: 130, right: 130, top: 15, bottom: 15),
                  ),
                )
              ],
            ),
          )),
        ],
      )),
    );
  }
}
