import 'package:flutter/material.dart';
import 'package:testings/screens/auth/login.dart';
import 'package:testings/screens/background.dart';

class FirstPg extends StatefulWidget {
  const FirstPg({Key? key}) : super(key: key);

  @override
  _FirstPgState createState() => _FirstPgState();
}

class _FirstPgState extends State<FirstPg> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        height: 100.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/getsurge.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Crypto & You',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 90),
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Text(
            //       'Get Started',
            //       style: TextStyle(
            //         color: Color(0xff464646),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       shape: new RoundedRectangleBorder(
            //         borderRadius: new BorderRadius.circular(20.0),
            //       ),
            //       elevation: 10,
            //       primary: Color(0xffD19549),
            //       padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(phoneController)));
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
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
              ),
            ),
            SizedBox(
              height: 116,
            ),
            // Container(
            //   height: 232.0,
            //   width: 500.0,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/surgeapp.png'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
