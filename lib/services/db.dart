import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testings/services/messaging.dart';

class Db {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? phoneCurrUser = FirebaseAuth.instance.currentUser?.phoneNumber;

  addUser(String email, String name, String phone) async {
    return await users.doc(phone).set({
      'email': email,
      'name': name,
    }).catchError((e) => print('db error' + e));
  }

  addMessages(String phone, int amount) async => await users
      .doc(phone)
      .collection('messages')
      .doc()
      .set(MessagingService().transations(amount));

  Stream<QuerySnapshot> get listenToDb => users.snapshots();

  Stream<QuerySnapshot> get listenToMessages => users
      .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();

  addCustomerId(String customerId) async =>
      await users.doc(phoneCurrUser).update({
        'cust_id': customerId,
      });
}
