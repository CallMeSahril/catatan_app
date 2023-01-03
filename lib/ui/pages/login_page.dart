import 'package:catatan_app/constant/typography.dart';
import 'package:catatan_app/provider/auth_provider.dart';
import 'package:catatan_app/ui/pages/main_page.dart';
import 'package:catatan_app/ui/pages/register_page.dart';
import 'package:catatan_app/ui/widgets/cta_button.dart';
import 'package:catatan_app/ui/widgets/password_field.dart';
import 'package:catatan_app/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController pwdController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    pwdController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    pwdController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    handleLogin() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        if (await auth.login(
            email: emailController.text, password: pwdController.text)) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.route, (route) => false);
        } else {}
        setState(() {
          isLoading = false;
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Masuk',
                          textAlign: TextAlign.center,
                          style: largeTitleStyle,
                        ),
                        const Spacer(flex: 2),
                        TextFormField(
                          controller: emailController,
                          validator: ValidationBuilder().email().build(),
                          decoration: const InputDecoration(
                            hintText: 'Masukkan Email Anda',
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        PasswordField(controller: pwdController),
                        const Spacer(flex: 2),
                        CTAButton(text: 'Masuk', onTap: handleLogin),
                        const Spacer(flex: 2),
                        const Text(
                          'Belum punya akun?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 2,
                            fontSize: 12,
                          ),
                        ),
                        TextLink(
                          'Daftar disini',
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.route);
                          },
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
