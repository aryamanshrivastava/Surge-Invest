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

  @override
  void initState() {
    widget.auth!.logInWIthPhone(phone: widget.phoneNumber!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Center(
              child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Verify Phone',
                  style: TextStyle(
                    color: Colors.black,
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
                    color: Colors.grey,
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
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 16,
                    style: TextStyle(fontSize: 20),
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
                              content: Text('Please fill the OTP'),
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
                    'VERIFY AND CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
