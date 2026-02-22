import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  String selectedType = '';

  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? pinError; // 👈 add this

  void updateType(String value) {
    selectedType = value;
    update();
  }

  Future<void> fetchCityState(String pincode) async {
    // Reset error first
    pinError = null;

    if (pincode.length != 6) {
      stateController.clear();
      cityController.clear();
      update();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.postalpincode.in/pincode/$pincode'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data[0]['Status'] == 'Success') {
          cityController.text = data[0]['PostOffice'][0]['District'] ?? '';
          stateController.text = data[0]['PostOffice'][0]['State'] ?? '';
          pinError = null;
        } else {
          /// Invalid pincode case
          cityController.clear();
          stateController.clear();
          pinError = "Invalid Pincode";
        }
      } else {
        pinError = "Something went wrong";
      }
    } catch (e) {
      pinError = "Unable to fetch data";
    }

    update();
  }
}

// class AddressController extends GetxController {
//   String selectedType = '';

//   final addressController = TextEditingController();
//   final pinCodeController = TextEditingController();
//   final stateController = TextEditingController();
//   final cityController = TextEditingController();

//   void updateType(String value) {
//     selectedType = value;
//     update();
//   }

//   Future<void> fetchCityState(String pincode) async {
//     if (pincode.length != 6) return;

//     final response = await http.get(
//       Uri.parse('https://api.postalpincode.in/pincode/$pincode'),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       if (data[0]['Status'] == 'Success') {
//         cityController.text = data[0]['PostOffice'][0]['District'] ?? '';
//         stateController.text = data[0]['PostOffice'][0]['State'] ?? '';
//         update();
//       }
//     }
//   }
// }
