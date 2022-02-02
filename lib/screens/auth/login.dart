import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testings/screens/auth/otp.dart';
import 'package:testings/services/auth.dart';
import 'package:testings/services/messaging.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(TextEditingController phoneController);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

const themeColor = const Color(0xff063970);

class _LoginScreenState extends State<LoginScreen> {

  _buildCard({
    Config? config,
    Color backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 152.0,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      child: Card(
        elevation: 12.0,
        margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: WaveWidget(
          config: config!,
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          size: Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }

  MaskFilter? _blur;
  final List<MaskFilter> _blurs = [
    // null,
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }

  final phoneController = TextEditingController();
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    MessagingService().getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff0473270),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(phoneController)));
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
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
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
              Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  maxLength: 10,
                  validator: (value){
                    if(value== null){
                      return 'Please enter phone number';
                    } else if(value.length<10 || int.tryParse(value) == null){
                      return 'Enter valid 10 digit phone number';
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var doc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc('+91' + phoneController.text)
                        .get();
                    if (doc.exists) {
                      _auth.logInWIthPhone(phone: phoneController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                phoneNumber: phoneController.text,
                                registered: true,
                                auth: _auth,
                              )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterScreen(phoneController)));
                    }
                  }
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
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  primary: Color(0xffD19549),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
              ),
              // Align(
              //   alignment: FractionalOffset.bottomCenter,
              //   child: _buildCard(
              //     backgroundColor: Color(0xff0473270),
              //     config: CustomConfig(
              //       gradients: [
              //         [Colors.deepPurple, Color(0xEEF44336)],
              //         [Colors.deepPurple[800]!, Color(0x77E57373)],
              //         [Colors.deepPurple, Color(0x66FF9800)],
              //         [Colors.deepPurple, Color(0x55FFEB3B)]
              //       ],
              //       durations: [35000, 19440, 10800, 6000],
              //       heightPercentages: [0.20, 0.23, 0.25, 0.30],
              //       blur: _blur,
              //       gradientBegin: Alignment.bottomLeft,
              //       gradientEnd: Alignment.topRight,
              //     ),
              //   ),
              // )
              // Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    ));
  }
}
