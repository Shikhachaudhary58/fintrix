import 'package:fintrix/controller/address_type_controller.dart';
import 'package:fintrix/screen/address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressTypeSelection extends StatelessWidget {
  final controller = Get.put(AddressTypeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressTypeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            /// Residential
            if (controller.selectedType == null ||
                controller.selectedType == "Residential")
              addressCard(
                title: "Residential",
                description:
                    "If you are a housewife or work from home then please select this option for your availability.",
                onTap: () => controller.selectType("Residential"),
              ),

            const SizedBox(height: 15),

            /// Communication
            if (controller.selectedType == null ||
                controller.selectedType == "Communication")
              addressCard(
                title: "Communication",
                description:
                    "If you are working class and available only at office premises in scheduled timings then select this option.",
                onTap: () => controller.selectType("Communication"),
              ),

            const SizedBox(height: 20),

            /// Show Address Form
            // if (controller.selectedType == "Residential")
            //   ResidentialAddressForm(),

            // if (controller.selectedType == "Communication")
            //   CommunicationAddressForm(),
          ],
        );
      },
    );
  }
}
