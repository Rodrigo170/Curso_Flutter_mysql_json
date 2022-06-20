import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantHomeController extends GetxController {
  var indexTab = 0.obs;

  void changeTab(int index) {
    //indice donde se va ubicar el usuario
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil(
        '/', (route) => false); //ELIMINA EL HISTORIAL DE PANTALLAS
  }
}
