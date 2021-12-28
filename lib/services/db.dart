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
      'amount': '0',
      'rp_authorized': false,
    }).catchError((e) => print('db error' + e));
  }

  addMessages(String phone, int amount) async {
    if (await rpAuth) {
      await users
          .doc(phone)
          .collection('messages')
          .doc()
          .set(MessagingService().transations(amount));
    }
  }

  Stream<DocumentSnapshot> get listenToDb =>
      users.doc(phoneCurrUser).snapshots();

  Stream<QuerySnapshot> get listenToMessages => users
      .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();

  addCustomerId(String customerId) async =>
      await users.doc(phoneCurrUser).update({'cust_id': customerId});

  addToken(String token) async {
    await users.doc(phoneCurrUser).update({
      'rp_authorized': true,
      'token': token,
    });
  }

  Future<String> get email async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('email');
  }

  Future<String> get name async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('name');
  }

  Future<bool> get auth async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('rp_authorized');
  }

  Future<String> get custId async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('cust_id');
  }

  Future<String> get token async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('token');
  }

  Future<bool> get rpAuth async {
    DocumentSnapshot snapshot = await users.doc(phoneCurrUser).get();
    return snapshot.get('rp_authorized');
  }
}
