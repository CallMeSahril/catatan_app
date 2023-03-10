import 'package:catatan_app/firebase_options.dart';
import 'package:catatan_app/provider/auth_provider.dart';
import 'package:catatan_app/provider/create_debt_provider.dart';
import 'package:catatan_app/provider/get_debt_provider.dart';
import 'package:catatan_app/ui/pages/add_debt_page.dart';
import 'package:catatan_app/ui/pages/login_page.dart';
import 'package:catatan_app/ui/pages/main_page.dart';
import 'package:catatan_app/ui/pages/register_page.dart';
import 'package:catatan_app/ui/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<DebtProvider>(
          create: (context) => DebtProvider(),
        ),
        ChangeNotifierProvider<CreateDebtProvider>(
          create: (context) => CreateDebtProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Catatan Hutang',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Wrapper.route,
        routes: {
          Wrapper.route: (context) => const Wrapper(),
          AddDebtPage.route: (context) => const AddDebtPage(),
          LoginPage.route: (context) => const LoginPage(),
          RegisterPage.route: (context) => const RegisterPage(),
          MainPage.route: (context) => const MainPage(),
        },
      ),
    );
  }
}
