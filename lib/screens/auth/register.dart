import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen(this.phoneController);

  final TextEditingController phoneController;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();

const themeColor = const Color(0xff063970);

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0473270),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(phoneController)));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color(0xff0503971),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            )),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
                          color: Color(0xffD19549),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Hello New User!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: nameController,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                      textCapitalization: TextCapitalization.words,
                      validator: (value){
                        if(value== null || value.isEmpty){
                          return 'Please enter name';
                        } else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Color(0xff0503971),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          ),
                          hintText: 'Name',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xffD19549),
                          ),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value== null){
                          return 'Please enter e-mail address';
                        } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                          return 'Enter valid Email';
                        } else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Color(0xff0503971),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          ),
                          hintText: 'Email Id',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xffD19549),
                          ),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: widget.phoneController,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                      maxLength: 10,
                      validator: (value){
                        if(value== null){
                          return 'Please enter phone number';
                        } else if(value.length<10 || int.tryParse(value) == null){
                          return 'Enter valid phone number';
                        } else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: Color(0xff0503971),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        hintText: 'Phone No.',
                        prefixIcon: const Icon(
                          Icons.call_outlined,
                          color: Color(0xffD19549),
                        ),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                phoneNumber: widget.phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                registered: false,
                                auth: _auth,
                              )));
                    }
                  },
                  child: Text(
                    'Register!',
                    style: TextStyle(
                      color: Color(0xff464646),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}