import 'package:flutter/material.dart';
import 'package:testings/verifyPhone.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

const themeColor = const Color(0xff063970);

class _LoginState extends State<Login> {

  final phoneNumberController = TextEditingController();

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: themeColor, //                   <--- border color
        width: 2.0,
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    super.dispose();
  }

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello from the default snackbar'),
        action: SnackBarAction(
          label: 'Click Me',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (context){
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: ()=>Navigator.pop(context),
                      ),
                    ),
                  ),
                  Center(
                      child:Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50),
                            Text(
                              'Please enter your mobile number',
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
                              'You will receive a 6 digit code\nto verify next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: myBoxDecoration(),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 7,),
                                  Container(
                                    height: 30,
                                    child: Image(image : AssetImage('assets/india.png')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      '+91',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          controller: phoneNumberController,
                                          style: TextStyle(
                                            letterSpacing: 2,
                                            fontSize: 20,
                                          ),
                                          decoration: InputDecoration(
                                              hintText: 'Mobile Number',
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.grey
                                              ),
                                              border: InputBorder.none,
                                              counterText: ''
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                              onPressed: (){
                                String phno = phoneNumberController.text;
                                if(phno.length<10){
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Invalid Phone Number'))
                                  );
                                }
                                else{
                                  var route = new MaterialPageRoute(
                                      builder: (BuildContext context)=>
                                      new VerifyPhone(phoneNumber: phoneNumberController.text,)
                                  );
                                  Navigator.of(context).push(route);
                                }
                              },
                              child: Text('CONTINUE',
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
                ],
              )
          );
        })
    );
  }
}
