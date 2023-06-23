import 'package:catatan_app/getx/login/login_gtx.dart';

import 'package:catatan_app/ui/pages/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  static const route = '/wrapper';

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.put<AuthController>(AuthController());

    return Obx(() {
      if (auth.userModel != null) {
        return const MainPage();
      } else {
        if (auth.userModel == null && auth.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return LoginPage();
        }
      }
    });
  }
}
