import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
// import 'package:indilink/ApiClient/api_client.dart';
// import 'package:indilink/Common/Helper/helper.dart';
// import 'package:indilink/Partner/Controller/partner_controller.dart';
// import 'package:indilink/utils/colors.dart';
// import 'package:indilink/utils/imageConstants.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:vph_web_date_picker/vph_web_date_picker.dart';
import 'package:intl/intl.dart';
// import 'package:dio/dio.dart' as dio;
import 'dart:io' as io;

class CustomTimeWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? hintError;
  final String? hint;
  final String? title;
  final dynamic maxLines;
  final Color? fillColor;
  final BuildContext context;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final Function(TimeOfDay)? onTimeSelected;
  bool isRequired;
  final bool use24HourFormat;

  CustomTimeWidget({
    super.key,
    required this.controller,
    required this.context,
    this.hintError,
    this.hint,
    this.title,
    this.maxLines,
    this.fillColor,
    this.borderRadius,
    this.validator,
    this.isRequired = true,
    this.onTimeSelected,
    this.use24HourFormat = true,
  });

  @override
  State<CustomTimeWidget> createState() => _CustomTimeWidgetState();
}

class _CustomTimeWidgetState extends State<CustomTimeWidget> {
  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final formattedTime = widget.use24HourFormat
          ? DateFormat('HH:mm').format(dt)
          : DateFormat('hh:mm a').format(dt);

      controller.text = formattedTime;

      if (widget.onTimeSelected != null) {
        widget.onTimeSelected!(pickedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                widget.title ?? '',
                maxLines: widget.maxLines ?? 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (widget.isRequired)
              const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ).paddingOnly(left: 5, bottom: 2),
        Center(
          child: InkWell(
            onTap: () => _selectTime(widget.context, widget.controller),
            child: TextFormField(
              controller: widget.controller,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              cursorHeight: 18,
              cursorWidth: 1.3,
              validator: widget.validator,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                  height: 0.4,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: widget.fillColor ?? const Color(0xffF7F7F7),
                prefixIcon: widget.controller.text.isEmpty
                    ? const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.grey,
                      )
                    : null,
                hintText: widget.controller.text.isEmpty
                    ? widget.hint
                    : widget.controller.text,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 5, vertical: 5);
  }
}
