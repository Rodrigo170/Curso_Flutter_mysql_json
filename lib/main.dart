import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter/src/models/user.dart';
import 'package:udemy_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:udemy_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:udemy_flutter/src/pages/home/home_page.dart';
import 'package:udemy_flutter/src/pages/login/login_page.dart';
import 'package:udemy_flutter/src/pages/register/register_page.dart';
import 'package:udemy_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:udemy_flutter/src/pages/roles/roles_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      title: 'Delivery Udemy',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/roles' : '/client/products/list' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/restaurant/orders/list', page: () => RestaurantOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: () => ClientProdudctListPage()),
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
          onSecondary: Colors.grey,
          background: Colors.grey
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
