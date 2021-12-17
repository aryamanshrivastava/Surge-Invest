import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testings/services/messaging.dart';

class Db {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  addUser(String uid, String email, String name) async {
    return await users.doc(uid).set({
      'email': email,
      'name': name,
    }).catchError((e) => print(e));
  }

  addMessages(String uid, int amount) async =>
      await users.doc(uid).update(MessagingService().transations(amount));

  Stream<QuerySnapshot> listenToDb() => users.snapshots();
}
