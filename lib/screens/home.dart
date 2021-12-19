import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testings/main.dart';
import 'package:testings/services/db.dart';
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
    //Stream<QuerySnapshot>? message =
    //Provider.of<Stream<QuerySnapshot>>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Surge'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Recent Transactions ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: Db().listenToMessages,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('data');
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            Timestamp time = doc['time'];
                            var parsedDT = time.toDate();
                            var date = DateFormat.yMMMd().format(parsedDT);
                            var tim = DateFormat.jm().format(parsedDT);
                            int amount = doc['amount'];
                            int rounded, invested;
                            if (amount < 100) {
                              if (amount % 5 == 0) {
                                invested = 5;
                              } else {
                                rounded = (amount / 5).ceil() * 5;
                                invested = rounded - amount;
                              }
                            } else {
                              rounded = (amount / 10).ceil() * 10;
                              invested = rounded - amount;
                            }

                            return ListTile(
                              title: Text('Rs.' + amount.toString()),
                              subtitle:
                                  Text(date.toString() + " " + tim.toString()),
                              trailing:
                                  Text("Invested Rs." + invested.toString()),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
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
