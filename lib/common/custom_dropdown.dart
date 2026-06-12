import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CommonDropDownWithLabel extends StatelessWidget {
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? labelText;
  String? titleText;
  String? type;
  bool? enabled;
  int? maxLength;
  String? Function(String?)? validator;
  List<String?> items;
  String? initialValue;
  EdgeInsetsGeometry? padding;
  TextEditingController? controller;
  void Function(String)? onChanged;
  TextCapitalization? textCapitalization;
  double? borderRadius;
  Color? fillColor;
  bool isRequired;
  Key? fieldKey;
  final String? value;
  final ValueNotifier<String?>? selectedValueNotifier;

  CommonDropDownWithLabel({
    super.key,
    this.labelText,
    this.value,
    this.titleText,
    this.enabled,
    this.initialValue,
    this.textCapitalization,
    this.borderRadius,
    this.suffixIcon,
    required this.items,
    this.onChanged,
    this.prefixIcon,
    this.controller,
    this.maxLength,
    this.type,
    this.padding,
    this.validator,
    this.fillColor,
    this.fieldKey,
    this.isRequired = true,
    this.selectedValueNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  titleText ?? '',
                  style: const TextStyle(
                    // color: AppColors.colortextGrey2,
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isRequired)
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      // color: AppColors.colorRed,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ).paddingOnly(bottom: 5),
            // .paddingOnly(left: 5, bottom: 2),
            items.length < 10
                ? ValueListenableBuilder<String?>(
                    valueListenable:
                        selectedValueNotifier ??
                        ValueNotifier<String?>(null), // Fallback if null
                    builder: (context, selectedValue, _) {
                      return CustomDropdown(
                        key: fieldKey,
                        enabled: enabled ?? true,
                        // initialItem: controller?.text.isNotEmpty == true
                        //     ? controller?.text
                        //     : null,
                        initialItem:
                            value ??
                            (items.contains(controller?.text)
                                ? controller?.text
                                : null), // Ensure initialItem matches items

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            if (isRequired) {
                              return 'required';
                            } else {
                              return null;
                            }
                          }
                          return null;
                        },
                        closedHeaderPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 10,
                        ),
                        disabledDecoration: CustomDropdownDisabledDecoration(
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(
                            // color: AppColors.colortextDarkGrey,
                            // color: AppColors.colorhinttextGrey,
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                          ),
                          headerStyle: const TextStyle(
                            // color: AppColors.colorBlack,
                            // color: AppColors.colorhinttextGrey,
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                          ),
                          // fillColor: AppColors.colorWhite,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        decoration: CustomDropdownDecoration(
                          searchFieldDecoration: const SearchFieldDecoration(
                            textStyle: TextStyle(
                              // color: AppColors.colorBlack,
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              // color: AppColors.colortextDarkGrey,
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          closedErrorBorder: Border.all(
                            width: 1,
                            // color: AppColors.colorRed
                          ),
                          closedBorder: Border.all(
                            width: 1,
                            color: Colors.grey.shade400,
                            // color: AppColors.colorTransparent
                          ),
                          expandedBorderRadius: BorderRadius.circular(
                            borderRadius ?? 8,
                          ),
                          closedErrorBorderRadius: BorderRadius.circular(
                            borderRadius ?? 8,
                          ),
                          closedBorderRadius: BorderRadius.circular(
                            borderRadius ?? 8,
                          ),
                          // closedSuffixIcon: Image.asset(
                          //   downArrow,
                          //   color: AppColors.colortextGrey2,
                          //   height: 6,
                          // )
                          // .paddingOnly(right: 8),
                          // expandedSuffixIcon: Image.asset(
                          //   upArrow,
                          //   color: AppColors.colortextGrey2,
                          //   height: 6,
                          // ),
                          // .paddingOnly(right: 8),
                          errorStyle: const TextStyle(
                            // color: AppColors.colorRed,
                            fontFamily: "Gilroy",
                            fontSize: 10,
                            height: 0.4,
                          ),
                          // expandedFillColor: AppColors.colorLightGrey,
                          closedFillColor: Colors.white,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            // color: AppColors.colortextGrey2,
                            //color: AppColors.colorhinttextGrey,
                            fontSize: 12,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                          ),
                          listItemStyle: const TextStyle(
                            // color: AppColors.colortextDarkGrey,
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                          ),
                          headerStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            // color: AppColors.colorBlack,
                          ),
                        ),
                        hintText: labelText ?? '',
                        items: items ?? [],
                        onChanged: (value) {
                          if (value != null && value is String) {
                            // Ensure value is not null and is a String
                            if (controller != null) {
                              controller!.text =
                                  value; // Safely update the controller text
                            }
                            if (onChanged != null) {
                              onChanged!(value);
                            }
                            selectedValueNotifier?.value = value;
                          }
                        },
                        // (String v) {
                        //   // print(v);

                        // },
                      );
                    },
                  )
                : CustomDropdown.search(
                    key: fieldKey,
                    enabled: enabled ?? true,
                    // initialItem: controller?.text.isNotEmpty == true
                    //     ? controller?.text
                    //     : null,
                    initialItem:
                        value ??
                        (items.contains(controller?.text)
                            ? controller?.text
                            : null), // Ensure initialItem matches items

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    closedHeaderPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
                    ),
                    disabledDecoration: CustomDropdownDisabledDecoration(
                      fillColor: fillColor,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        // color: AppColors.colortextDarkGrey,
                        // color: AppColors.colorhinttextGrey,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                      ),
                      headerStyle: const TextStyle(
                        color: Colors.grey,
                        // color: AppColors.colorBlack,
                        // color: AppColors.colorhinttextGrey,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
                      // fillColor: AppColors.colorWhite,
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                        // color: AppColors.colorTransparent
                      ),
                    ),
                    noResultFoundBuilder: (context, text) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          'No Result Found',
                          style: TextStyle(
                            // color: AppColors.colorBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
                    ),
                    decoration: CustomDropdownDecoration(
                      searchFieldDecoration: const SearchFieldDecoration(
                        textStyle: TextStyle(
                          // color: AppColors.colorBlack,
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          // color: AppColors.colortextDarkGrey,
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      closedErrorBorder: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                        // color: AppColors.colorRed
                      ),
                      closedBorder: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                        // color: AppColors.colorTransparent
                      ),
                      expandedBorderRadius: BorderRadius.circular(
                        borderRadius ?? 8,
                      ),
                      closedErrorBorderRadius: BorderRadius.circular(
                        borderRadius ?? 8,
                      ),
                      closedBorderRadius: BorderRadius.circular(
                        borderRadius ?? 8,
                      ),
                      // closedSuffixIcon: Image.asset(
                      //   // downArrow,
                      //   // color: AppColors.colortextGrey2,
                      //   // height: 6,
                      // ),
                      // .paddingOnly(right: 8),
                      // expandedSuffixIcon: Image.asset(
                      //   // upArrow,
                      //   // color: AppColors.colortextGrey2,
                      //   // height: 6,
                      // ),
                      // .paddingOnly(right: 8),
                      errorStyle: const TextStyle(
                        // color: AppColors.colorRed,
                        fontFamily: "Gilroy",
                        fontSize: 10,
                        height: 0.4,
                      ),
                      // expandedFillColor: AppColors.colorCardColor,
                      // expandedFillColor: AppColors.colorLightGrey,
                      closedFillColor: Colors.white,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        // color: AppColors.colortextGrey2,
                        //color: AppColors.colorhinttextGrey,
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                      ),
                      listItemStyle: const TextStyle(
                        // color: AppColors.colortextDarkGrey,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400,
                      ),
                      headerStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        // color: AppColors.colorBlack,
                      ),
                    ),
                    hintText: labelText ?? '',
                    items: items ?? [],
                    onChanged: (value) {
                      if (value != null && value is String) {
                        // Ensure value is not null and is a String
                        if (controller != null) {
                          controller!.text =
                              value; // Safely update the controller text
                        }
                        if (onChanged != null) {
                          onChanged!(value);
                        }
                      }
                    },
                    // (String v) {
                    //   // print(v);

                    // },
                  ),
          ],
        ),
      ],
    );
    // .paddingSymmetric(horizontal: 5, vertical: 5);
  }
}
