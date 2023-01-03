import 'package:catatan_app/models/debt_model.dart';
import 'package:catatan_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  static Future<dynamic> getUserByEmail(String email) async {
    CollectionReference ref = _firestore.collection('users');

    QuerySnapshot querySnapshot =
        await ref.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }

  Future<UserModel> getDataUser() async {
    var respone = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var data = respone.data();
    if (data!.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } else {
      throw Exception('Data Kosong');
    }
  }

  Future getDatadebt() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection("debt")
          .orderBy("date")
          // .where(
          //   "user_id",
          //   isEqualTo: userID,
          // )
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add(element);
        }
      });
      return itemsList;
    } catch (e) {
      throw Exception('Data Kosong');
    }
  }

  Future createTransaction({
    required String title,
    required String total,
  }) async {
    final docTransaction =
        FirebaseFirestore.instance.collection('transaction').doc();

    final debt = DebtModel(
        date: DateTime.now(),
        title: title,
        total: int.parse(total),
        userID: userId);

    final json = debt.toJson();
    return await docTransaction.set(json);
  }

  static Future<void> delete(
      {required String collectionName, required String documentID}) async {
    _firestore.collection(collectionName).doc(documentID).delete().catchError(
          (e) {},
        );
  }
}
