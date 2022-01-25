import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testings/services/db.dart';

class Locker extends StatefulWidget {
  const Locker({Key? key}) : super(key: key);

  @override
  _LockerState createState() => _LockerState();
}

class _LockerState extends State<Locker> {
  Db db = Db();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff0D104E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.yellow, width: 3.0),
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xff000000).withOpacity(0.1),
              child: StreamBuilder<DocumentSnapshot>(
                stream: db.listenToDb,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Live Price',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Live Price',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(width: 10,),
                                  Spacer(),
                                  Text(
                                    '${snapshot.data!['amount'] ?? '0'} BTC',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Withdraw',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5, 0.5),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    primary: Color(0xff8A00FF),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                ),
                                SizedBox(width: 30),
                                //Spacer(),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.5, 0.5),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    primary: Color(0xff8A00FF),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
