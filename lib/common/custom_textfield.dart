import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CommonTextFieldWithLabel extends StatelessWidget {
  bool? obscureText;
  FocusNode? focusNode;
  bool isDoubleHeight;
  Key? fieldKey;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? labelText;
  String? titleText;
  String? subtitleText;
  String? initialValue;
  TextInputType? keyboardType;
  String? type;
  int? maxLength;
  String? Function(String?)? validator;
  String? Function(String?)? onSubmitted;
  EdgeInsetsGeometry? padding;
  TextEditingController? controller;
  void Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  TextCapitalization? textCapitalization;
  double? borderRadius;
  // List<TextInputFormatter>? inputFormatters;
  Color? fillColor;
  bool? enabled;
  bool? doNotcloseKeyOntapOutside;
  Color hintColor;
  bool? readOnly;
  bool isRequired;

  CommonTextFieldWithLabel({
    super.key,
    this.labelText,
    this.focusNode,
    this.titleText,
    this.subtitleText,
    this.textCapitalization,
    this.borderRadius,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.initialValue,
    this.onChanged,
    this.prefixIcon,
    this.controller,
    // this.inputFormatters,
    this.maxLength,
    this.type,
    this.padding,
    this.validator,
    this.onSubmitted,
    this.fillColor,
    this.enabled,
    this.fieldKey,
    this.doNotcloseKeyOntapOutside,
    this.onSaved,
    this.readOnly = false,
    this.hintColor = Colors.grey,
    this.isRequired = true,
    this.isDoubleHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                (subtitleText != null) ? (subtitleText!) : titleText ?? '',
                //maxLines: 1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: subtitleText != null
                    ? const TextStyle(
                        // color: AppColors.colortextDarkGrey,
                        // color: AppColors.colortextGrey2,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      )
                    : const TextStyle(
                        // color: AppColors.colortextDarkGrey,
                        // color: AppColors.colorBlack,
                        // color: AppColors.colortextGrey2,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                      ),
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
        TextFormField(
          minLines: isDoubleHeight ? 2 : 1,
          maxLines: isDoubleHeight ? 2 : 1,
          key: fieldKey,
          focusNode: focusNode,
          enabled: enabled ?? true,
          initialValue: initialValue,
          textAlign: TextAlign.start,
          readOnly: readOnly ?? false,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onChanged: onChanged,
          onSaved: onSaved,
          onTapOutside: (event) {
            (doNotcloseKeyOntapOutside ?? false)
                ? null
                : FocusManager.instance.primaryFocus?.unfocus();
          },
          onFieldSubmitted:
              onSubmitted ??
              (value) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
          // cursorColor: AppColors.colorFormTitleBg,
          cursorHeight: 20,
          cursorWidth: 1.3,
          controller: controller,
          validator: validator,
          // inputFormatters: inputFormatters ??
          //     ((keyboardType == TextInputType.number ||
          //             keyboardType == TextInputType.phone)
          //         ? [FilteringTextInputFormatter.digitsOnly]
          //         : (keyboardType != TextInputType.emailAddress)
          //             ? [CapitalizeFirstLetterTextFormatter()]
          //             : null),
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600,
            color: Colors.black,
            // color: AppColors.colorBlack,
          ),
          decoration: InputDecoration(
            // hoverColor: AppColors.colorBGCX,
            contentPadding:
                padding ??
                (isDoubleHeight
                    ? const EdgeInsets.symmetric(vertical: 18, horizontal: 10)
                    : const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),

            hintText: labelText,
            errorStyle: const TextStyle(
              color: Colors.red,
              // color: AppColors.colorRed,
              fontSize: 11,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w400,
              height: 0.4,
            ),
            hintStyle: TextStyle(
              color: hintColor, // Use dynamic hint color
              fontSize: 12,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
            ),
            // hintStyle: const TextStyle(
            //   color: AppColors.colortextGrey2,
            //   //color: AppColors.colorhinttextGrey,
            //   fontSize: 16,
            //   fontFamily: 'Gilroy',
            //   fontWeight: FontWeight.w400,
            // ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: suffixIcon,
            ),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 8,
              ), // Customize the border radius as needed
              borderSide:
                  // BorderSide.none
                  const BorderSide(
                    color: Colors.transparent,
                  ), // Removes the default border
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide:
                  //  BorderSide.none
                  const BorderSide(color: Colors.transparent),
            ),
            focusColor: fillColor ?? Colors.white,
            // hoverColor: fillColor ?? AppColors.colorWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide:
                  //  BorderSide.none
                  const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 8,
              ), // Customize the border radius as needed
              borderSide:
                  //  BorderSide.none
                  const BorderSide(
                    color: Colors.transparent,
                  ), // Customize the border color when focused
            ),
          ),
        ),
      ],
    );
    // .paddingSymmetric(horizontal: 5, vertical: 5);
  }
}
