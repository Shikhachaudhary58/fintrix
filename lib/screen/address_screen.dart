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
import 'package:gap/gap.dart';
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
                          // if (controller.selectedType.isEmpty)
                          //   const Text(
                          //     'Select Address Type',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // Text(
                          //   controller.selectedType.isEmpty
                          //       ? 'Select Type'
                          //       : 'Selected Type',
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),

                          // const SizedBox(height: 10),
                          // const SizedBox(height: 10),

                          /// Show options only when nothing is selected
                          // if (controller.selectedType.isEmpty) ...[
                          //   RadioListTile<String>(
                          //     hoverColor: Colors.grey,

                          //     contentPadding: EdgeInsets.zero,
                          //     value: "Residential",
                          //     groupValue: controller.selectedType,
                          //     onChanged: (value) {
                          //       controller.updateType(value ?? '');
                          //     },
                          //     title: const Text("Residential"),
                          //     subtitle: const Text(
                          //       "If you are a housewife or work from home then please select this option for your availability.",
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         color: Color.fromARGB(255, 107, 107, 107),
                          //       ),
                          //     ),
                          //   ),

                          //   RadioListTile<String>(
                          //     hoverColor: Colors.grey,
                          //     contentPadding: EdgeInsets.zero,
                          //     value: "Communication",
                          //     groupValue: controller.selectedType,
                          //     onChanged: (value) {
                          //       controller.updateType(value ?? '');
                          //     },
                          //     activeColor: Colors.blue,

                          //     tileColor: WidgetStateColor.resolveWith((states) {
                          //       if (states.contains(WidgetState.hovered)) {
                          //         return Colors.grey.shade200;
                          //       }
                          //       return Colors.transparent;
                          //     }),
                          //     title: const Text("Communication"),
                          //     subtitle: const Text(
                          //       "If you are working class and available only at office premises in scheduled timings then select this option.",
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         color: Color.fromARGB(255, 107, 107, 107),
                          //       ),
                          //     ),
                          //   ),
                          // ],
                          CommonDropDownWithLabel(
                            isRequired: true,
                            items: const ["Residential", "Communication"],
                            titleText: 'Select Address Type',
                            labelText: controller.selectedType.isEmpty
                                ? "Select here"
                                : controller.selectedType,
                            onChanged: (value) {
                              controller.updateType(value ?? '');
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'required';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          /// ✅ SHOW ONLY WHEN EMPTY
                          if (controller.selectedType.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _bulletText(
                                    "Select 'Residential' if your primary availability is at your residential address during standard working hours or throughout the day.",
                                  ),
                                  const SizedBox(height: 8),
                                  _bulletText(
                                    "Select 'Communication' if you are generally available at your workplace during business hours for communication, verification, or follow-up actions.",
                                  ),
                                ],
                              ),
                            ),

                          // if (controller.selectedType.isEmpty)
                          //   Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 6.0,
                          //     ),
                          //     child: Text(
                          //       "Select 'Residential' if your primary availability is at your residential address during standard working hours or throughout the day.\n\n"
                          //       // "Select 'Residential' if you are available at home.\n"
                          //       "Select 'Communication' if you are generally available at your workplace during business hours for communication, verification, or follow-up actions./n",
                          //       // "Select 'Communication' if you are available at office during working hours.",
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         color: Colors.grey.shade600,
                          //         height: 1.4,
                          //       ),
                          //     ),
                          //   ),

                          // if (controller.selectedType.isEmpty) ...[
                          //   _infoCard(
                          //     title: "Residential",
                          //     description: "If you are a housewife...",
                          //   ),
                          //   const SizedBox(height: 12),
                          //   _infoCard(
                          //     title: "Communication",
                          //     description: "If you are working class...",
                          //   ),
                          // ],

                          /// After selection show only selected type
                          // if (controller.selectedType.isNotEmpty) ...[
                          //   CommonDropDownWithLabel(
                          //     isRequired: true,
                          //     items: const ["Residential", "Communication"],
                          //     titleText: 'Selected Address Type',
                          //     labelText: controller.selectedType,
                          //     onChanged: (value) {
                          //       controller.updateType(value ?? '');
                          //     },
                          //     validator: (value) {
                          //       if (value!.isEmpty || value.trim().isEmpty) {
                          //         return 'required';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          //   // if (controller.selectedType.isEmpty) ...[
                          //   //   _infoCard(
                          //   //     title: "Residential",
                          //   //     description:
                          //   //         "If you are a housewife or work from home then please select this option for your availability.",
                          //   //   ),
                          //   //   const SizedBox(height: 12),
                          //   //   _infoCard(
                          //   //     title: "Communication",
                          //   //     description:
                          //   //         "If you are working class and available only at office premises in scheduled timings then select this option.",
                          //   //   ),
                          //   // ],
                          //   // CommonTextFieldWithLabel(
                          //   //   titleText: 'Selected Type',
                          //   //   labelText: controller.selectedType,
                          //   //   controller: TextEditingController(
                          //   //     text: controller.selectedType,
                          //   //   ),
                          //   //   isRequired: true,
                          //   //   readOnly: true,
                          //   //   suffixIcon: InkWell(
                          //   //     child: Icon(
                          //   //       Icons.edit_outlined,
                          //   //       color: Colors.black,
                          //   //     ),
                          //   //     onTap: () {
                          //   //       controller.updateType('');
                          //   //     },
                          //   //   ),
                          //   // ),

                          //   // Gap(6),
                          //   // Align(
                          //   //   alignment: Alignment.centerRight,
                          //   //   child: TextButton(
                          //   //     onPressed: () {
                          //   //       controller.updateType('');
                          //   //     },
                          //   //     child: const Text("Change"),
                          //   //   ),
                          //   // ),
                          //   // Text(
                          //   //   controller.selectedType,
                          //   //   style: const TextStyle(
                          //   //     fontSize: 16,
                          //   //     fontWeight: FontWeight.w500,
                          //   //   ),
                          //   // ),
                          // ],

                          // CommonDropDownWithLabel(
                          //   isRequired: true,
                          //   items: const ["Residential", "Communication"],
                          //   titleText: 'Select Type',
                          //   labelText: 'Select here',
                          //   onChanged: (value) {
                          //     controller.updateType(value ?? '');
                          //   },
                          //   validator: (value) {
                          //     if (value!.isEmpty || value.trim().isEmpty) {
                          //       return 'required';
                          //     }
                          //     return null;
                          //   },
                          // ),
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
                                    controller: controller.fromTimeController,
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
                                    controller: controller.toTimeController,
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
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.pinError != null) {
                                    Get.snackbar("Error", controller.pinError!);
                                    return;
                                  }

                                  Get.to(
                                    () => VoiceRecordingScreen(),
                                    arguments: {
                                      "address": controller.getFullAddress(),
                                      "time": controller.getTime(),
                                    },
                                  );
                                }
                                // if (controller.formKey.currentState!
                                //     .validate()) {
                                //   Get.to(VoiceRecordingScreen());
                                // }
                              },
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

  Widget _bulletText(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 14)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard({required String title, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
