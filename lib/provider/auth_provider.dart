import 'package:catatan_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    // _getDataUser();
  }
  final _auth = FirebaseAuth.instance;

  Stream<User?> changeState() {
    return _auth.authStateChanges();
  }

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  set userModel(UserModel? user) {
    _userModel = user;
    notifyListeners();
  }

  Future register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(email: email, phone: phone, name: name);
      FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set(user.toJson());
    } catch (e) {
      throw Exception('Gagal Register');
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
