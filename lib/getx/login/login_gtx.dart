import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  UserModel? get userModel => _userModel.value;
  RxBool isLoading = false.obs;

  Stream<User?> changeState() {
    return _auth.authStateChanges();
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      isLoading.value = true;

      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(email: email, phone: phone, name: name);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set(user.toJson());

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception('Gagal Register');
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}
