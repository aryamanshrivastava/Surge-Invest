import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawScreen extends StatefulWidget {
  final btcBal;
  const WithdrawScreen({Key? key, this.btcBal}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

FocusNode focusNode = FocusNode();
TextEditingController textEditingController = TextEditingController();

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  void initState() {
    textEditingController.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0473270),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Withdraw',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xffF9A42F),
                            child: FaIcon(
                              FontAwesomeIcons.btc,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              '${widget.btcBal} available',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xffF9A42F),
                              child: FaIcon(
                                FontAwesomeIcons.btc,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 8,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                              ),
                              controller: textEditingController,
                              autofocus: true,
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, bottom: 11, top: 11, right: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(double.parse(textEditingController.text)>double.parse(widget.btcBal)){
                            Fluttertoast.showToast(
                                msg: "Withdraw amount can not be greater than available balance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red.shade400,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          } else{
                            FirebaseFirestore.instance.collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.phoneNumber!)
                                .update({
                              'amount': (double.parse(widget.btcBal)-double.parse(textEditingController.text)).toString(),
                            });
                            FirebaseFirestore.instance.collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.phoneNumber!).collection('withdraw').doc()
                                .set({
                              'amount':
                                      double.parse(textEditingController.text)
                                  .toString(),
                              'time': DateTime.now()
                            });
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Withdraw successful",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        },
                        child: Text(
                          'WITHDRAW',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          primary: Color(0xff14EE80),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
