import 'package:flutter/material.dart';

import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child:Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 50,
                    child: Icon(
                      Icons.photo_outlined,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Welcome to SURGE',
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
                    'Please register to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 50,),
                  SizedBox(height: 30,),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                    onPressed: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ),
                    child: Text('REGISTER',
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
      ),
    );
  }
}
