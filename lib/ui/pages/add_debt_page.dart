import 'package:catatan_app/provider/create_debt_provider.dart';
import 'package:catatan_app/provider/get_debt_provider.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../widgets/cta_button.dart';

class AddDebtPage extends StatefulWidget {
  static const route = '/add_debt';
  const AddDebtPage({super.key});

  @override
  State<AddDebtPage> createState() => _AddDebtPageState();
}

class _AddDebtPageState extends State<AddDebtPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController totalController;
  @override
  void initState() {
    titleController = TextEditingController();
    totalController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    totalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DebtProvider debtProvider = Provider.of<DebtProvider>(context);
    CreateDebtProvider debtCreate = Provider.of<CreateDebtProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Hutang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: ValidationBuilder().build(),
                decoration: const InputDecoration(
                  hintText: 'Judul',
                ),
                style: const TextStyle(fontSize: 12),
              ),
              TextFormField(
                controller: totalController,
                keyboardType: TextInputType.number,
                validator: ValidationBuilder().build(),
                decoration: const InputDecoration(
                  hintText: 'Hutang',
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              CTAButton(
                text: 'Tambah Hutang',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    debtCreate
                        .createTransaction(
                            title: titleController.text,
                            total: totalController.text)
                        .then((value) => {
                              debtProvider.refreshData(),
                              Navigator.pop(context),
                            });
                  } else {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
