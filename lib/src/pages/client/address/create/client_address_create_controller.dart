import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:udemy_flutter/src/pages/client/address/map/client_address_map_page.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController neighorhoodController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  void openGoogleMaps(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientAddressMapPage(),
        isDismissible: false,
        enableDrag: false);
  }
}
