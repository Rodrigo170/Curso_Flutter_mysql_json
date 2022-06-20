import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/src/models/category.dart';
import 'package:udemy_flutter/src/models/response_api.dart';
import 'package:udemy_flutter/src/provides/categories_provider.dart';

class RestaurantCategoriesCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController decripcionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  void createCategory() async {
    String name = nameController.text;
    String description = decripcionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(name: name, description: description);

      ResponseApi responseApi = await categoriesProvider.create(category);

      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Formulario no valido',
          'Ingresa todos los campas para crear la categoria');
    }
  }

  void clearForm() {
    nameController.text = '';
    decripcionController.text = '';
  }
}
