import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final Telephony telephony = Telephony.instance;
List<String> messages = [];
bool _isLoading = true;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _isLoading = true;
    getPermissions();
    getMessages();
    super.initState();
    telephony.listenIncomingSms(onNewMessage: (SmsMessage message) async {
          if(message.body.toString().contains(new RegExp(r'([Rr]s\.)|([Ss]ent)|([Ff]rom)|([Pp]aid)|([Dd]ebited)')) && !(message.body.toString().contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)')))){
            if(RegExp(r'(?<=(Rs\.))[0-9]*\.?[0-9]*').firstMatch(message.body.toString())?.group(0) != null){
              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('messages').doc().set({
                'amount': RegExp(r'(?<=(Rs\.))[0-9]*\.?[0-9]*').firstMatch(message.body.toString())?.group(0),
                'time': Timestamp.now()
              });
            }
          }
        },
        onBackgroundMessage: backgroundMessageHandler
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Surge'),
        ),
        body: _isLoading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Recent transactions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),)),
                ),
                Column(
                    children: messages.map((item) => new ListTile(
                        title: Text('₹ '+item),
                      leading: Icon(Icons.account_balance_wallet),
                    )).toList()
                ),
              ],
            )
        )
    );
  }

  getPermissions() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted!) {
      print('Permissions Granted');
    } else {
      await telephony.requestPhoneAndSmsPermissions;
    }
  }

  getMessages() async {
    FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .collection('messages').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          messages.add(doc["amount"]);
        });
      });
    }).whenComplete(() => _isLoading = false);
  }
}
