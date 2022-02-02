import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testings/services/db.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0473270),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'All Transactions',
              style: TextStyle(
                color: Color(0xff14EE80),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder(
            stream: Db().listenToMessages,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('data');
              } else {
                return Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                          if (amount % 10 == 0) {
                            invested = 10;
                          } else {
                            rounded = (amount / 10).ceil() * 10;
                            invested = rounded - amount;
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff555555),
                            ),
                            child: ListTile(
                              title: Text(
                                'Spent ₹' + amount.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                date.toString() + " " + tim.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 35,
                                width: 95,
                                decoration: BoxDecoration(
                                    color: Color(0xff141414),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Invested ₹" + invested.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff14EE80),
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
