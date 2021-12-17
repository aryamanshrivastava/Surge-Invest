import 'package:firebase_auth/firebase_auth.dart';
import 'package:testings/models/users.dart';
import 'package:testings/services/db.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = Db();

  UserModel? _mapUser(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }

  Stream<UserModel?>? get user => _auth.authStateChanges().map(_mapUser);

  Future<UserModel?> signIn(String email, String password) async {
    final creds = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUser(creds.user);
  }

  Future<UserModel?> signUp(String email, String password, String name) async {
    final creds = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (creds.user != null) {
      _db.addUser(creds.user!.uid, email, name);
    }
    return _mapUser(creds.user);
  }

  Future<void> signOut() async => await _auth.signOut();
}
