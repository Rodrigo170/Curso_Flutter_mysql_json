import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter/src/models/user.dart';
import 'package:udemy_flutter/src/pages/home/home_page.dart';
import 'package:udemy_flutter/src/pages/login/login_page.dart';
import 'package:udemy_flutter/src/pages/register/register_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Delivery Udemy',
        debugShowCheckedModeBanner: false,
        initialRoute: userSession.id != null
            ? '/home'
            : '/', // SI YA SE INICIO SESIÓN LO DIRGE A RUTA HOME PERO SI NO AL LOGIN
        getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/register', page: () => RegisterPage()),
          GetPage(name: '/home', page: () => HomePage())
        ],
        theme: ThemeData(
            primaryColor: Colors.amber,
            colorScheme: ColorScheme(
                primary: Colors.amber,
                secondary: Colors.amberAccent,
                brightness: Brightness.light,
                onBackground: Colors.grey,
                onPrimary: Colors.grey,
                surface: Colors.grey,
                onSurface: Colors.grey,
                error: Colors.grey,
                onError: Colors.grey,
                background: Colors.grey,
                onSecondary: Colors.grey)),
        navigatorKey: Get.key);
  }
}
