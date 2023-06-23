import 'package:catatan_app/constant/typography.dart';
import 'package:catatan_app/provider/auth_provider.dart';
import 'package:catatan_app/ui/pages/login_page.dart';
import 'package:catatan_app/ui/pages/main_page.dart';
import 'package:catatan_app/ui/widgets/cta_button.dart';
import 'package:catatan_app/ui/widgets/password_field.dart';
import 'package:catatan_app/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const route = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  late final TextEditingController nameController;
  late final TextEditingController pwdController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    pwdController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    pwdController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
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
                        const Spacer(flex: 2),
                        const Text(
                          'Daftar Akun',
                          textAlign: TextAlign.center,
                          style: largeTitleStyle,
                        ),
                        const Spacer(flex: 2),
                        TextFormField(
                          controller: nameController,
                          validator: ValidationBuilder().build(),
                          decoration: const InputDecoration(
                            hintText: 'Masukkan Nama Anda',
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          validator: ValidationBuilder().email().build(),
                          decoration: const InputDecoration(
                            hintText: 'Masukkan Email Anda',
                          ),
                          style: const TextStyle(fontSize: 12),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 8),
                        PasswordField(controller: pwdController),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: phoneController,
                          validator: ValidationBuilder().phone().build(),
                          decoration: const InputDecoration(
                            hintText: 'Masukkan Nomor Telepon Anda',
                          ),
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Text(
                          'Dengan mendaftar, Anda telah menyetujui',
                          style: TextStyle(
                            height: 3,
                            fontSize: 10,
                          ),
                        ),
                        const Text(
                          'Syarat Ketentuan & Kebijakan Privasi',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                        const Spacer(),
                        CTAButton(
                          text: 'Daftar',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              auth
                                  .register(
                                      email: emailController.text,
                                      password: pwdController.text,
                                      name: nameController.text,
                                      phone: phoneController.text)
                                  .then((value) =>
                                      Navigator.pushReplacementNamed(
                                          context, MainPage.route));
                            } else {}
                          },
                        ),
                        const Spacer(),
                        const Text(
                          'Sudah punya akun?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 2,
                            fontSize: 12,
                          ),
                        ),
                        TextLink(
                          'Masuk disini',
                          onTap: () {
                            // Navigator.pushNamedAndRemoveUntil(
                            //   context,
                            //   LoginPage.route,
                            //   (route) => false,
                            // );
                          },
                        ),
                        const Spacer(),
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
