import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telephony/telephony.dart';
import 'package:testings/services/db.dart';

class MessagingService {
  final Telephony telephony = Telephony.instance;

  getPermissions() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted!) {
      print('Permissions Granted');
    } else {
      await telephony.requestPhoneAndSmsPermissions;
    }
  }

  Map<String, dynamic> transations(int amount) {
    return {
      'time': DateTime.now(),
      'amount': amount,
    };
  }

  incomingMessageHandler(SmsMessage message) async {
    print("incoming" + message.body!);
    if (message.body.toString().contains(new RegExp(
            r'([Rr]s\.?)|([Ss]ent)|([Ff]rom)|([Pp]aid)|([Dd]ebited)')) &&
        !(message.body.toString().contains(
            new RegExp(r'([Ff]ailed)|([Cc]redited)|([Rr]received)')))) {
      if (RegExp(r'(?<=(Rs))\.? ?[0-9]*')
              .firstMatch(message.body.toString())
              ?.group(0) !=
          null) {
        String? temp = RegExp(r'(?<=(Rs))\.? ?[0-9]*')
            .firstMatch(message.body.toString())
            ?.group(0);
        if (temp![0] == ' ' || temp[0] == '.') {
          temp = temp.substring(1);
        }
        int amount = int.parse(temp);
        // int amount = int.parse(RegExp(r'(?<=(Rs))\.? ?[0-9]*')
        //         .firstMatch(message.body.toString())
        //         ?.group(0) ??
        //     '0');
        print(amount);
        return await Db().addMessages(
            FirebaseAuth.instance.currentUser!.phoneNumber!,
            amount);
      }
    }
  }
}
