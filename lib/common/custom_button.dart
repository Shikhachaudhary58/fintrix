import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

GestureDetector customButton({
  double? hieght,
  required String title,
  VoidCallback? onTap,
  Color? bgColor,
  double? borderRadius,
  bool isDisabled = false,
  TextStyle? style,
}) {
  return GestureDetector(
    onTap: isDisabled ? null : onTap,
    child: Container(
      width: Get.width,
      height: hieght ?? 50,
      decoration: ShapeDecoration(
        color: Colors.black,
        // color: isDisabled
        //     ? AppColors.colorBlack.withOpacity(0.1)
        //     : bgColor ?? AppColors.colorBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
        ),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style:
              style ??
              const TextStyle(
                // color: AppColors.colorWhite,
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    ),
  );
}
