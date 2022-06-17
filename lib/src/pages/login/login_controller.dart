import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter/src/models/response_api.dart';
import 'package:udemy_flutter/src/provides/user_provides.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider userProvider = UsersProvider();

  void goToRegiterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim(); //elimana los espacios
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Passsword ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await userProvider.login(email, password);
      print('Response api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage()
            .write('user', responseApi.data); //DATOS DEL USUARIO EN SESIÓN
        goToHomePage(); //NULL SAFETY
      } else {
        Get.snackbar('Login exitoso', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario invalido', 'Debes ingresar el email');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
}
