import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Color(0xff0473270),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xff0503971),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                    color: Color(0xffD19549),
                  ),
                ),
                SizedBox(width: 70),
                Text(
                  'Sell Bitcoin',
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xffE4A951),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Current Sell Price',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff533B6D),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    '₹27,26,564.11',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '/1BTC',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price Valid for',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '6:30PM',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Available to sell',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff533B6D),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    '14 BTC',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Sell',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Card(
            color: Color(0xff533B6D),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xffF9A42F),
                    child: FaIcon(
                      FontAwesomeIcons.btc,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '0.25',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Value in rupees',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Card(
            color: Color(0xff533B6D),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xffF00B85B),
                    child: FaIcon(
                      FontAwesomeIcons.rupeeSign,
                      size: 20,
                      color: Color(0xff533B6D),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '699115.55',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Approximate Value available: ₹699115.55',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Sell',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'History',
              style: TextStyle(
                color: Color(0xff464646),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              elevation: 10,
              primary: Color(0xffD19549),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
          ),
        ],
      ),
    ));
  }
}
