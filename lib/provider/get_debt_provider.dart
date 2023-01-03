import 'package:catatan_app/models/debt_model.dart';
import 'package:catatan_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DebtProvider extends ChangeNotifier {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  DebtProvider() {
    _fetchDatabaseList();
  }
  List allDebtDataList = [];

  final _listTotal = [];
  List<DebtModel> _debtModel = [];
  int _sumTotal = 0;
  int get sumTotal => _sumTotal;
  List<DebtModel> get debtModel => _debtModel;

  set debtModel(List<DebtModel> user) {
    _debtModel = user;
    notifyListeners();
  }

  set sumTotal(int v) {
    _sumTotal = v;
    notifyListeners();
  }

  Future refreshData() async {
    _debtModel.clear();
    _listTotal.clear();
    _sumTotal = 0;
    _fetchDatabaseList();
  }

  Future _fetchDatabaseList() async {
    dynamic resultant = await AuthService().getDatadebt();

    if (resultant != null) {
      allDebtDataList = resultant;
      print(allDebtDataList.length);
      for (var i = 0; i < allDebtDataList.length; i++) {
        if (allDebtDataList[i]["user_id"] == userId) {
          _listTotal.add(allDebtDataList[i]["total"]);
          _debtModel.add(DebtModel(
            date: DateTime.parse(allDebtDataList[i]["date"]),
            title: allDebtDataList[i]["title"],
            total: allDebtDataList[i]["total"],
            userID: allDebtDataList[i]["user_id"],
            uuid: allDebtDataList[i]["uuid"],
          ));
        } else {}
      }
      _sumTotal = _listTotal.reduce((a, b) => a + b);
      sumTotal = _sumTotal;
      debtModel = _debtModel;
    }
  }
}
