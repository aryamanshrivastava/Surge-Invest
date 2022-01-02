import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:telephony/telephony.dart';
import 'package:testings/app.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/helpers.dart';
import 'package:testings/services/razorpay.dart';

backgroundMessageHandler(SmsMessage message) async {
  await Firebase.initializeApp();
  print("incoming bg" + message.body!);
  if (
  message.body.toString().contains(new RegExp(r'([Rr]s\.?)')) &&
      message.body.toString().contains(new RegExp(r'([Ss]ent)|([Pp]aid)|([Dd]ebited)|DEBITED')) &&
      !(message.body.toString().contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)|[Rr]azorpay|[Uu]nsuccessful|[Pp]ending')))
  ){
    if (RegExp(r'(?<=([Rr]s)\.* *)[0-9]*')
            .firstMatch(message.body.toString())
            ?.group(0) !=
        null) {
      String? temp = RegExp(r'(?<=([Rr]s))\.? ?[0-9]*')
          .firstMatch(message.body.toString())
          ?.group(0);
      if (temp![0] == ' ' || temp[0] == '.') {
        temp = temp.substring(1);
      }
      int amount = int.parse(temp);
      if (amount > 10) {
        SubsequentPayment().subsequentPayment(Helpers().invested(amount) * 100);
        return await Db().addMessages(
            FirebaseAuth.instance.currentUser!.phoneNumber!, amount);
      }
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SurgeApp());
}
