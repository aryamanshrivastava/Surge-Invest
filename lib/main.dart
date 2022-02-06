import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:testings/app.dart';
import 'package:workmanager/workmanager.dart' as work;

String phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
RegExp rsRegex = RegExp(r'([Rr]s\.?)');
RegExp successKeywordsRegex =
    RegExp(r'([Ss]ent)|([Pp]aid)|([Dd]ebited)|DEBITED');
RegExp failureKeywordsRegex = RegExp(
    r'([Ff]ailed)|([Cc]redited)|([Rr]eceived)|[Rr]azorpay|[Uu]nsuccessful|[Pp]ending');
RegExp amountRetrieveRegex = RegExp(r'(?<=([Rr]s)\.* *)[0-9]*');

Future<void> callbackDispatcher() async {

  work.Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case backgroundTask:
        await Firebase.initializeApp();
        FirebaseFirestore.instance.collection('users').doc(phone).collection('bg').doc().set(
            {'time': DateTime.now()});
        if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
          final prefs = await SharedPreferences.getInstance();
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
              .collection('background')
              .doc()
              .set({'time': DateTime.now()});
          int timeStamp = prefs.getInt('timestamp') ??
              DateTime.now().millisecondsSinceEpoch;
          List<SmsMessage> messages = await telephony.getInboxSms(
              columns: [SmsColumn.BODY, SmsColumn.DATE],
              filter: SmsFilter.where(SmsColumn.DATE)
                  .greaterThanOrEqualTo(timeStamp.toString()),
              sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)]);
          for (var i in messages) {
            if (i.body.toString().contains(rsRegex) &&
                i.body.toString().contains(successKeywordsRegex) &&
                !(i.body.toString().contains(failureKeywordsRegex))) {
              if (amountRetrieveRegex.firstMatch(i.body.toString())?.group(0) !=
                  null) {
                String? temp =
                    amountRetrieveRegex.firstMatch(i.body.toString())?.group(0);
                if (temp![0] == ' ' || temp[0] == '.') {
                  temp = temp.substring(1);
                }
                int amount = int.parse(temp);
                if (amount > 10) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.phoneNumber!)
                      .collection('messages')
                      .doc(i.date!.toString())
                      .set({
                    'amount': amount,
                    'time': DateTime.fromMillisecondsSinceEpoch(i.date!)
                  });
                }
              }
            }
          }
          prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
        } else {}
    }
    return Future.value(true);
  });
}

const backgroundTask = "backgroundTask";
final Telephony telephony = Telephony.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  work.Workmanager().initialize(callbackDispatcher);
  work.Workmanager().registerPeriodicTask(
    "5",
    backgroundTask,
    frequency: Duration(minutes: 20)
  );
  await Firebase.initializeApp();
  runApp(SurgeApp());
}
