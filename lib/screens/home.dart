import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testings/main.dart';
import 'package:testings/services/messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final telephony = Telephony.instance;

  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: MessagingService().incomingMessageHandler,
      onBackgroundMessage: backgroundMessageHandler,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Surge'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          )),
    );
  }

//   getMessages() async {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
//         .collection('messages')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         setState(() {
//           messages.add(doc["amount"]);
//         });
//       });
//     }).whenComplete(() => _isLoading = false);
//   }
}
