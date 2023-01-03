import 'package:catatan_app/provider/get_debt_provider.dart';
import 'package:catatan_app/services/auth_services.dart';
import 'package:catatan_app/ui/pages/add_debt_page.dart';
import 'package:catatan_app/utility/rupiah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const route = '/main_page';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    DebtProvider debtProvider = Provider.of<DebtProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddDebtPage.route);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Catatan Hutang"),
        actions: [
          Center(
              child: Text(
            rupiah(debtProvider.sumTotal),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return debtProvider.refreshData();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Consumer<DebtProvider>(
            builder: (context, value, child) => ListView.builder(
              itemCount: value.debtModel.length,
              itemBuilder: (context, index) {
                final debt = value.debtModel[index];
                return ListTile(
                  title: Text(debt.title!),
                  subtitle: Row(
                    children: [
                      Text(
                        rupiah(debt.total!),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(debt.date.toString())
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        AuthService.delete(
                                collectionName: 'debt',
                                documentID: debt.uuid.toString())
                            .then((value) => debtProvider.refreshData());
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
