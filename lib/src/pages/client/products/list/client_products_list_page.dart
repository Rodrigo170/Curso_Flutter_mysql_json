import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/src/models/category.dart';
import 'package:udemy_flutter/src/models/product.dart';
import 'package:udemy_flutter/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:udemy_flutter/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:udemy_flutter/src/pages/register/register_page.dart';
import 'package:udemy_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:udemy_flutter/src/utils/custom_animated_bottom_bar.dart';

import '../../../../widgets/no_data_widget.dart';

class ClientProdudctListPage extends StatelessWidget {
  ClientProdudctListController con = Get.put(ClientProdudctListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.categories.length,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.amber,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[700],
                    tabs: List<Widget>.generate(con.categories.length, (index) {
                      return Tab(
                        child: Text(con.categories[index].name ?? ''),
                      );
                    }),
                  ),
                ),
              ),
              body: TabBarView(
                children: con.categories.map((Category category) {
                  return FutureBuilder(
                      future: con.getProducts(
                          category.id ?? '1', con.productName.value),
                      builder:
                          (context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (_, index) {
                                  return _cardProduct(
                                      context, snapshot.data![index]);
                                });
                          } else {
                            return NoDataWidget(text: 'No hay productos');
                          }
                        } else {
                          return NoDataWidget(text: 'No hay productos');
                        }
                      });
                }).toList(),
              )),
        ));
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 15),
                  Text(
                    '\$${product.price.toString()}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              trailing: Container(
                height: 70,
                width: 60,
                // padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1!)
                        : AssetImage('assets/img/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey[300],
            indent: 37,
            endIndent: 37,
          )
        ],
      ),
    );
  }
}
