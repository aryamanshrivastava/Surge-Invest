import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testings/app.dart';


// final Telephony telephony = Telephony.instance;
// backgroundMessageHandler(SmsMessage message) async {
//   if( && message.body.toString().contains(new RegExp(r'([Rr]s\.)|([Ss]ent)|([Ff]rom)|([Pp]aid)|([Dd]ebited)')) && !(message.body.toString().contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)')))){
//     if(RegExp(r'(?<=(Rs\.))[0-9]*\.?[0-9]*').firstMatch(message.body.toString())?.group(0) != null){
//       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection('messages').doc().set({
//         'amount': RegExp(r'(?<=(Rs\.))[0-9]*\.?[0-9]*').firstMatch(message.body.toString())?.group(0),
//         'time': Timestamp.now()
//       });
//     }
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SurgeApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Surge',
//       home: MyHomePage(title: 'Surge'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// SharedPreferences? prefs;

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {

//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     Widget firstWidget;

//     if (firebaseUser != null) {
//       firstWidget = HomeScreen();
//     } else {
//       firstWidget = WelcomePage();
//     }
//     return MaterialApp(
//       home: firstWidget,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
