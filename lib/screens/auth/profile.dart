import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D104E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue[200],
                    child: CircleAvatar(
                      radius: 43,
                      backgroundImage: NetworkImage(
                          'https://www.w3schools.com/w3images/avatar2.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RichText(
                    text: TextSpan(
                      text: 'Hi, Investor',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                    alignment: Alignment.topRight,
                    onPressed: _signOut,
                    icon: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
