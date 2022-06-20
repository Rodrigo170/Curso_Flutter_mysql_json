import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProdudctListPage extends StatelessWidget {
  ClientProdudctListController con = Get.put(ClientProdudctListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Client Products List'),
            ElevatedButton(
          onPressed: () => con.signOut(),
          child: Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.black),
          ),
        ),
          ],
        ),
      ),
    );
  }
}