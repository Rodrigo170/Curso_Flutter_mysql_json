import 'package:get/get.dart';
import 'package:udemy_flutter/src/environment/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';

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

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('$url/login', {
      'email': email,
      'password': password
    }, headers: {
      'Content-Type': 'application/json'
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejeutar la petición');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
