import 'package:fintrix/common/appbar.dart';
import 'package:fintrix/common/custom_button.dart';
import 'package:fintrix/common/custom_dropdown.dart';
import 'package:fintrix/common/custom_textfield.dart';
import 'package:fintrix/controller/address_controller.dart';
import 'package:fintrix/screen/raise_query.dart';
import 'package:fintrix/screen/recording.dart';
import 'package:fintrix/screen/voice_record.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  final AddressController controller = Get.put(AddressController());
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: kIsWeb ? false : true,
      appBar: appBarWidget('Address'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          final bool isMobile = screenWidth < 600;
          final bool isTablet = screenWidth >= 600 && screenWidth < 1000;
          final bool isWeb = screenWidth >= 1000;

          double formWidth;

          if (isMobile) {
            formWidth = screenWidth;
          } else if (isTablet) {
            formWidth = 500;
          } else {
            formWidth = 650;
          }
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: formWidth,
                padding: const EdgeInsets.all(24),
                child: GetBuilder<AddressController>(
                  builder: (_) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropDownWithLabel(
                            isRequired: true,
                            items: const ["Residential", "Communication"],
                            titleText: 'Select Type',
                            labelText: 'Select here',
                            onChanged: (value) {
                              controller.updateType(value ?? '');
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.trim().isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          /// Show fields when any type is selected
                          if (controller.selectedType.isNotEmpty) ...[
                            /// Dynamic Heading
                            Text(
                              controller.selectedType == "Residential"
                                  ? "Residential Address"
                                  : "Communication Address",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Pincode
                            CommonTextFieldWithLabel(
                              //items: const [],
                              titleText: 'Pincode',
                              maxLength: 6,
                              controller: controller.pinCodeController,
                              labelText: 'Enter pincode',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.fetchCityState(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                            ),

                            // TextField(
                            //   controller: controller.pinCodeController,
                            //   keyboardType: TextInputType.number,
                            //   maxLength: 6,
                            //   decoration: InputDecoration(
                            //     labelText: "Pincode",
                            //     border: const OutlineInputBorder(),
                            //     errorText: controller.pinError,
                            //   ),
                            // onChanged: (value) {
                            //   controller.fetchCityState(value);
                            // },
                            // ),
                            const SizedBox(height: 16),

                            /// State
                            CommonTextFieldWithLabel(
                              //items: const [],
                              controller: controller.stateController,
                              titleText: 'State',
                              // maxLength: 6,
                              // controller: quantityController,
                              labelText: 'State',
                              validator: (value) {
                                if (value!.isEmpty || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                            ),

                            // TextField(
                            //   controller: controller.stateController,
                            //   readOnly: true,
                            //   decoration: const InputDecoration(
                            //     labelText: "State",
                            //     border: OutlineInputBorder(),
                            //   ),
                            // ),
                            const SizedBox(height: 16),

                            /// City
                            CommonTextFieldWithLabel(
                              //items: const [],
                              controller: controller.cityController,
                              titleText: 'City',
                              // maxLength: 6,
                              // controller: quantityController,
                              labelText: 'City',
                              validator: (value) {
                                if (value!.isEmpty || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                            ),

                            // TextField(
                            //   controller: controller.cityController,
                            //   readOnly: true,
                            //   decoration: const InputDecoration(
                            //     labelText: "City",
                            //     border: OutlineInputBorder(),
                            //   ),
                            // ),
                            const SizedBox(height: 16),

                            /// Address Field (Dynamic Label)
                            CommonTextFieldWithLabel(
                              //items: const [],
                              controller: controller.addressController,
                              titleText:
                                  controller.selectedType == "Residential"
                                  ? "Residential Address"
                                  : "Communication Address",
                              // maxLength: 6,
                              // controller: quantityController,
                              labelText:
                                  controller.selectedType == "Residential"
                                  ? "Residential Address"
                                  : "Communication Address",
                              maxLength: 25,
                              validator: (value) {
                                if (value!.isEmpty || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            Text('Availablity time (Optional)'),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CommonTextFieldWithLabel(
                                    isRequired: false,
                                    //items: const [],
                                    // controller: controller.stateController,
                                    titleText: 'From',
                                    // maxLength: 6,
                                    // controller: quantityController,
                                    labelText: 'From',
                                  ),
                                ),

                                SizedBox(width: 10),
                                Flexible(
                                  child: CommonTextFieldWithLabel(
                                    isRequired: false,
                                    //items: const [],
                                    // controller: controller.cityController,
                                    titleText: 'To',
                                    // maxLength: 6,
                                    // controller: quantityController,
                                    labelText: 'To',
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),
                            customButton(
                              title: 'Next',
                              onTap: () {
                                // if (controller.formKey.currentState!
                                //     .validate()) {
                                Get.to(VoiceRecordingScreen());
                              },
                              // },
                              // onTap: () => Get.to(VoiceRecordingScreen()),
                            ),
                          ],
                        ],
                      ),
                    );

                    // Column(
                    //   children: [
                    //     CommonDropDownWithLabel(
                    //       items: const ["Residential", "Communication"],
                    //       // controller: unitController,
                    //       titleText: 'Select Type',
                    //       labelText: 'Select here',
                    //       onChanged: (value) {
                    //         controller.updateType(value ?? '');
                    //       },
                    //       // validator: (value) {
                    //       //   if (value!.isEmpty) {
                    //       //     return AppConstants.requiredText;
                    //       //   } else {
                    //       //     return null;
                    //       //   }
                    //       // },
                    //     ),

                    //     /// Dropdown
                    //     // DropdownButtonFormField<String>(
                    //     //   decoration: const InputDecoration(
                    //     //     labelText: "Select Type",
                    //     //     border: OutlineInputBorder(),
                    //     //   ),
                    //     //   items: const [
                    //     //     DropdownMenuItem(
                    //     //       value: "Residential",
                    //     //       child: Text("Residential"),
                    //     //     ),
                    //     //     DropdownMenuItem(
                    //     //       value: "Communication",
                    //     //       child: Text("Communication"),
                    //     //     ),
                    //     //   ],
                    //     // onChanged: (value) {
                    //     //   controller.updateType(value ?? '');
                    //     // },
                    //     // ),
                    //     const SizedBox(height: 20),

                    //     /// Show only when Residential selected
                    //     if (controller.selectedType == "Residential") ...[
                    //       TextField(
                    //         controller: controller.pinCodeController,
                    //         keyboardType: TextInputType.number,
                    //         maxLength: 6,
                    //         decoration: const InputDecoration(
                    //           labelText: "Pincode",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //         onChanged: (value) {
                    //           controller.fetchCityState(value);
                    //         },
                    //       ),

                    //       const SizedBox(height: 16),

                    //       TextField(
                    //         controller: controller.stateController,
                    //         readOnly: true,
                    //         decoration: const InputDecoration(
                    //           labelText: "State",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //       ),

                    //       const SizedBox(height: 16),

                    //       TextField(
                    //         controller: controller.cityController,
                    //         readOnly: true,
                    //         decoration: const InputDecoration(
                    //           labelText: "City",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //       ),
                    //       const SizedBox(height: 16),
                    //       TextField(
                    //         controller: controller.addressController,
                    //         decoration: const InputDecoration(
                    //           labelText: "Residential Address",
                    //           border: OutlineInputBorder(),
                    //         ),
                    //       ),
                    //     ],
                    //   ],
                    // );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('Address'),),
    //   body: Column(
    //     children: [
    //       GetBuilder<AddressController>(
    //       builder: (_) {
    //         return  DropdownButtonFormField<String>(
    //               decoration: const InputDecoration(
    //                 labelText: "Select Type",
    //                 border: OutlineInputBorder(),
    //               ),
    //               items: const [
    //                 DropdownMenuItem(
    //                   value: "Residential",
    //                   child: Text("Residential"),
    //                 ),
    //                 DropdownMenuItem(
    //                   value: "Communication",
    //                   child: Text("Communication"),
    //                 ),
    //               ],
    //               onChanged: (value) {
    //                 controller.updateType(value ?? '');
    //               },
    //             );

    //           // return CommonDropDownWithLabel(
    //           //               // key: dropdownKey,
    //           //               // fieldKey: stateNameFieldKey,
    //           //               items:[],
    //           //                   // controller.sortedStates, // Use the observable map
    //           //               labelText: 'Enter State',
    //           //               titleText: 'State',
    //           //               // controller: stateNameController,
    //           //               onChanged: (value) {
    //           //                 // stateNameController.text = value;
    //           //                 // controller.setSelectedState(value);
    //           //                 // cityNameController.text = '';
    //           //                 // cityNameController.clear();
    //           //                 // dropdownKey1 = UniqueKey();
    //           //                 // controller.selectedCity = '';
    //           //                 // controller.update();
    //           //                 // cityNameController.clear();
    //           //                 // controller.selectedCity = '';

    //           //                 // controller.cities.clear();
    //           //               },
    //           //               // validator: (value) {
    //           //               //   if (value == null || value.isEmpty) {
    //           //               //     return AppConstants.requiredText;
    //           //               //   }
    //           //               //   return null;
    //           //               // },
    //           //             );

    //         }
    //       ),
    //                   //  CommonDropDownWithLabel(
    //                   //   // key: dropdownKey,
    //                   //   // fieldKey: stateNameFieldKey,
    //                   //   items:[],
    //                   //       // controller.sortedStates, // Use the observable map
    //                   //   labelText: 'Enter City',
    //                   //   titleText: 'City',
    //                   //   // controller: stateNameController,
    //                   //   onChanged: (value) {
    //                   //     // stateNameController.text = value;
    //                   //     // controller.setSelectedState(value);
    //                   //     // cityNameController.text = '';
    //                   //     // cityNameController.clear();
    //                   //     // dropdownKey1 = UniqueKey();
    //                   //     // controller.selectedCity = '';
    //                   //     // controller.update();
    //                   //     // cityNameController.clear();
    //                   //     // controller.selectedCity = '';

    //                   //     // controller.cities.clear();
    //                   //   },
    //                   //   // validator: (value) {
    //                   //   //   if (value == null || value.isEmpty) {
    //                   //   //     return AppConstants.requiredText;
    //                   //   //   }
    //                   //   //   return null;
    //                   //   // },
    //                   // )
    //     ],
    //   ),
    // );
  }
}
