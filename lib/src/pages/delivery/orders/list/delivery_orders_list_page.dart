import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:udemy_flutter/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';

class DeliveryOrdersListPage extends StatelessWidget {
 
 ClientProdudctListController con = Get.put(ClientProdudctListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Client Products List'),
      ),
    );
  }
}