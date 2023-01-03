import 'package:catatan_app/models/debt_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CreateDebtProvider extends ChangeNotifier {
  Future createTransaction({
    required String title,
    required String total,
  }) async {
    final docTransaction = FirebaseFirestore.instance.collection('debt').doc();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final debtModel = DebtModel(
      userID: userId,
      title: title,
      total: int.parse(total),
      date: DateTime.now(),
      uuid: docTransaction.id,
    );

    final json = debtModel.toJson();

    await docTransaction.set(json);
    notifyListeners();
  }
}
