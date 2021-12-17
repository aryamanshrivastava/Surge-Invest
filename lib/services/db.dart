import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  addUser(String uid, String email, String name) async {
    return users.doc(uid).set({
      'email': email,
      'name': name,
    }).catchError((e) => print(e));
  }
}
