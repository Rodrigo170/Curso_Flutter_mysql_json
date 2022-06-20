import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:udemy_flutter/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:udemy_flutter/src/pages/register/register_page.dart';
import 'package:udemy_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:udemy_flutter/src/utils/custom_animated_bottom_bar.dart';

class ClientProdudctListPage extends StatelessWidget {
  ClientProdudctListController con = Get.put(ClientProdudctListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('CLIENT PRODUCTS LIST'),
    ));
  }
}
