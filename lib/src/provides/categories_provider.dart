import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter/src/models/category.dart';
import 'package:udemy_flutter/src/models/response_api.dart';

import '../environment/environment.dart';
import '../models/user.dart';

class CategoriesProvider extends GetConnect {
  String url = Environment.API_URL + 'api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Category>> getAll() async {
    Response response = await get('$url/getAll', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada', 'Tu usuario no esta autorizado');
      return [];
    }

    List<Category> categories = Category.fromJsonList(response.body);

    return categories;
  }

  Future<ResponseApi> create(Category category) async {
    Response response = await post('$url/create', category.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
