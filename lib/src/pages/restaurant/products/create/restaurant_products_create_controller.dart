import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:udemy_flutter/src/models/category.dart';
import 'package:udemy_flutter/src/models/product.dart';
import 'package:udemy_flutter/src/models/response_api.dart';
import 'package:udemy_flutter/src/provides/categories_provider.dart';
import 'package:udemy_flutter/src/provides/products_provider.dart';

class RestaurantProductsCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController decripcionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var idCategory = ''.obs;
  List<Category> categories = <Category>[].obs;
  ProductsProvider productsProvider = ProductsProvider();

  RestaurantProductsCreateController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void createProduct(BuildContext context) async {
    String name = nameController.text;
    String description = decripcionController.text;
    String price = priceController.text;
    print('NAME: ${name}');
    print('DESCRIPCTION: ${description}');
    print('PRICE: ${price}');
    print('ID CATEGORY: ${idCategory}');
    ProgressDialog progressDialog = ProgressDialog(context: context);
    if (isValidForm(name, description, price)) {
      Product product = Product(
          name: name,
          description: description,
          price: double.parse(price),
          idCategory: idCategory.value);
      progressDialog.show(max: 100, msg: 'Espere un momento...');

      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);

      Stream stream = await productsProvider.create(product, images);
      stream.listen((res) {
        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        if (responseApi.success == true) {
          clearForm();
        }
      });
    }
  }

  bool isValidForm(String name, String description, String price) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del producto');
      return false;
    }
    if (description.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Ingresa la descripción del producto');
      return false;
    }
    if (price.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el precio del producto');
      return false;
    }
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del producto');
      return false;
    }
    if (idCategory.value == '') {
      Get.snackbar('Formulario no valido',
          'Debes seleccionar la categoria del producto');
      return false;
    }
    if (imageFile1 == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen 1');
      return false;
    }
    if (imageFile2 == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen 2');
      return false;
    }
    if (imageFile3 == null) {
      Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen 3');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      } else if (numberFile == 2) {
        imageFile2 = File(image.path);
      } else if (numberFile == 3) {
        imageFile3 = File(image.path);
      }
      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButtom = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(color: Colors.black),
        ));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(color: Colors.black),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opción'),
      actions: [galleryButtom, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void clearForm() {
    nameController.text = '';
    decripcionController.text = '';
    priceController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }
}
