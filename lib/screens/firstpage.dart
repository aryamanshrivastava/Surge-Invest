import 'package:flutter/material.dart';
import 'package:testings/screens/auth/login.dart';

class FirstPg extends StatefulWidget {
  const FirstPg({Key? key}) : super(key: key);

  @override
  _FirstPgState createState() => _FirstPgState();
}

var _height;
var _width;

class _FirstPgState extends State<FirstPg> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0473270),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/app.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Positioned(
                //     bottom: 0,
                //     child: Text(
                //           'Crypto & You',
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 25,
                //               fontWeight: FontWeight.bold),
                //         ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Color(0xff464646),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                elevation: 10,
                primary: Color(0xffD19549),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(phoneController)));
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Color(0xff464646),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              elevation: 10,
              primary: Color(0xffD19549),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
          ),
          Spacer(),
          Container(
            height: _height/10*2,
            width: _width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/waveio.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}