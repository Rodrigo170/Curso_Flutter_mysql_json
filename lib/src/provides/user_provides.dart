import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:udemy_flutter/src/environment/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

// class UserProvider extends GetConnect {
//   String url =
//       Environment.API_URL + 'api/users'; //Apunta a las rutas del usuario

//   //Metodo
//   // Defini un http
//   Future<Response> create(User user) async {
//     Response response = await post('$url/create', user.toJson(),
//         headers: {'Content-Type': 'application/json'});
//     // ESPERA HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
//     return response;
//   }
// }

class UsersProvider extends GetConnect {
  String url = Environment.API_URL + 'api/users';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    return response;
  }

  // SIN IMAGEN
  Future<ResponseApi> update(User user) async {
    Response response =
        await put('$url/updateWithoutImage', user.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('$url/login', {
      'email': email,
      'password': password
    }, headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
