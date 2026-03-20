import 'package:get/get.dart';

class AddressTypeController extends GetxController {
  String? selectedType;
  String hoveredOption = '';

  void setHover(String value) {
    hoveredOption = value;
    update();
  }

  void selectType(String type) {
    selectedType = type;
    update();
  }
}
