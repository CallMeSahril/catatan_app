import 'package:catatan_app/constant/typography.dart';
import 'package:catatan_app/ui/pages/main_page.dart';

import 'package:catatan_app/ui/pages/register_page.dart';
import 'package:catatan_app/ui/widgets/cta_button.dart';
import 'package:catatan_app/ui/widgets/password_field.dart';
import 'package:catatan_app/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../getx/login/login_gtx.dart';

class LoginPage extends StatelessWidget {
  static const route = '/loginPage';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    void handleLogin() async {
      if (_formKey.currentState!.validate()) {
        AuthController auth = Get.find<AuthController>();
        bool loginSuccess = await auth.login(
          email: emailController.text,
          password: pwdController.text,
        );
        print("INI APA : $loginSuccess");
        if (loginSuccess) {
          // Navigasi ke halaman utama setelah login berhasil
          Get.offAllNamed(MainPage.route);
        } else {
          // Tampilkan pesan gagal login
          Get.snackbar(
            'Gagal Login',
            'Email atau password salah.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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
                            Get.toNamed(RegisterPage.route);
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
