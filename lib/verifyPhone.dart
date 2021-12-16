import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_text_field/otp_field.dart';

import 'home.dart';

class VerifyPhone extends StatefulWidget {

  final String phoneNumber;
  VerifyPhone({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

const themeColor = const Color(0xff063970);

class _VerifyPhoneState extends State<VerifyPhone> {
  String sentCode = '';

  String enteredOTP='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (context){
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30,
                        onPressed: ()=>Navigator.pop(context),
                      ),
                    ),
                  ),
                  Center(
                      child:Container(
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
                            SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 16,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                onCompleted: (pin) {
                                  enteredOTP = pin;
                                },
                                onChanged: (pin){},
                              ),
                            ),
                            SizedBox(height: 20,),
                            RichText(
                              text: TextSpan(
                                  text: 'Didn\'t receive the code?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(text: ' Request Again',
                                        style: TextStyle(
                                            color: Colors.blueAccent, fontSize: 18),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(content: Text('Code sent again'))
                                            );
                                          }
                                    )
                                  ]
                              ),
                            ),
                            SizedBox(height: 40,),
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                              onPressed: (){
                                if(enteredOTP.length<6){
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Invalid Code'))
                                  );
                                }
                                else {
                                  _verifyCode(enteredOTP);
                                }
                              },
                              child: Text('VERIFY AND CONTINUE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: themeColor,
                            )
                          ],
                        ),
                      )
                  ),
                ],
              )
          );
        })
    );
  }

  _verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91"+widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async{
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async{
            if(value.user!=null){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken){
          sentCode = verificationID;
        },
        codeAutoRetrievalTimeout:(String verificationId){}
    );
  }

  _verifyCode(String pin) async{
    try{
      await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: sentCode,
              smsCode: pin
          )).then((value) async{
        if(value.user!=null){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
          );
        }
      });
    } catch(e){
      FocusScope.of(context).unfocus();
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Wrong Code, Please try again!'),
            );
          }
      );
    }
  }
}
