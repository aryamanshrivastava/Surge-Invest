import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:testings/app.dart';
import 'package:workmanager/workmanager.dart' as work;

void callbackDispatcher() {
  work.Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case backgroundTask:
        await Firebase.initializeApp();
        // bool? permissionsGranted = await telephony.requestSmsPermissions;
        if(
        // permissionsGranted! &&
            FirebaseAuth.instance.currentUser!= null ){
          final prefs = await SharedPreferences.getInstance();
          int timeStamp = prefs.getInt('timestamp')?? DateTime.now().millisecondsSinceEpoch;
          // DateTime now = DateTime.now();
          // int timeStamp = DateTime(now.year, now.month, now.day-8, 0, 0).millisecondsSinceEpoch;
          List<SmsMessage> messages = await telephony.getInboxSms(
              columns: [SmsColumn.BODY, SmsColumn.DATE],
              filter: SmsFilter.where(SmsColumn.DATE).greaterThanOrEqualTo(timeStamp.toString()),
              sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)]
          );
          for(var i in messages){
            if (i.body.toString().contains(new RegExp(r'([Rr]s\.?)')) &&
                i.body.toString().contains(new RegExp(r'([Ss]ent)|([Pp]aid)|([Dd]ebited)|DEBITED')) &&
                !(i.body.toString().contains(new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]eceived)|[Rr]azorpay|[Uu]nsuccessful|[Pp]ending')))){
              if (RegExp(r'(?<=([Rr]s)\.* *)[0-9]*')
                  .firstMatch(i.body.toString())
                  ?.group(0) !=
                  null) {
                String? temp = RegExp(r'(?<=([Rr]s))\.? ?[0-9]*')
                    .firstMatch(i.body.toString())
                    ?.group(0);
                if (temp![0] == ' ' || temp[0] == '.') {
                  temp = temp.substring(1);
                }
                int amount = int.parse(temp);
                if (amount > 10) {
                  FirebaseFirestore.instance.collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.phoneNumber!)
                      .collection('messages')
                      .doc()
                      .set({
                    'amount': amount,
                    'time': DateTime.fromMillisecondsSinceEpoch(i.date!)
                  });
                }
              }
            }
          }
          prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
        } else{

        }
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
    frequency: Duration(minutes: 30),
    constraints: work.Constraints(
        networkType: work.NetworkType.connected,
    )
  );
  await Firebase.initializeApp();
  runApp(SurgeApp());
}