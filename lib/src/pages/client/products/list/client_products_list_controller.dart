import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:udemy_flutter/src/provides/categories_provider.dart';
import 'package:udemy_flutter/src/provides/products_provider.dart';

import '../../../../models/category.dart';
import '../../../../models/product.dart';
import '../detail/client_products_detail_page.dart';

class ClientProdudctListController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  //List<Product> selectedProducts = [];

  List<Category> categories = <Category>[].obs;
  var items = 0.obs;

  var productName = ''.obs;
  //Timer? searchOnStoppedTyping;

  ClientProdudctListController() {
    getCategories();
  }

  /*void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName.value = text;
      print('TEXTO COMPLETO: ${text}');
    });
  }*/

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    print(result);
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(
      String idCategory, String productName) async {
    if (productName.isEmpty) {
      return await productsProvider.findByCategory(idCategory);
    } else {
      return await productsProvider.findByNameAndCategory(
          idCategory, productName);
    }
  }

  void goToOrderCreate() {
    Get.toNamed('/client/orders/create');
  }

  void openBottomSheet(BuildContext context, Product product) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientProductsDetailPage(product: product),
    );
  }
}
