import 'package:flutter/material.dart';
import 'package:testings/screens/auth/register.dart';
import 'package:testings/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

const themeColor = const Color(0xff063970);

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                    border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                    border: InputBorder.none,
                    counterText: ''),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth
                    .signIn(emailController.text.trim(),
                        passwordController.text.trim())
                    .catchError((err) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("ERROR"),
                          content: Text(err.message),
                          actions: [
                            TextButton(
                              child: Text(
                                "OK",
                                style: new TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                });
              },
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
