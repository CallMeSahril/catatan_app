import 'package:catatan_app/provider/auth_provider.dart';
import 'package:catatan_app/ui/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'main_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  static const route = '/wrapper';

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return StreamBuilder<User?>(
      stream: auth.changeState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return (snapshot.data != null) ? const MainPage() : const LoginPage();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
