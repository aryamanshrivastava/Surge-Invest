import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:telephony/telephony.dart';
import 'package:testings/app.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/helpers.dart';
import 'package:testings/services/razorpay.dart';

backgroundMessageHandler(SmsMessage message) async {
  print("incoming" + message.body!);
  if (message.body.toString().contains(new RegExp(
          r'([Rr]s\.)|([Ss]ent)|([Ff]rom)|([Pp]aid)|([Dd]ebited)')) &&
      !(message.body
          .toString()
          .contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)')))) {
    if (RegExp(r'(?<=(Rs)\.* *)[0-9]*')
            .firstMatch(message.body.toString())
            ?.group(0) !=
        null) {
      int amount = int.parse(RegExp(r'(?<=(Rs)\.* *)[0-9]*')
              .firstMatch(message.body.toString())
              ?.group(0) ??
          '0');
      SubsequentPayment().subsequentPayment(Helpers().invested(amount)*100);
      return await Db()
          .addMessages(FirebaseAuth.instance.currentUser!.phoneNumber!, amount);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SurgeApp());
}