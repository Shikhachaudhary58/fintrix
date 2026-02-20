import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

appBarWidget(
  String title, {
  bool showBackButton = true,
  String? assetImagePath,
  // int? navKey,
  Widget? action,
}) {
  // {String? assetImagePath, int? navKey, Widget? action}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    forceMaterialTransparency: true,
    leading: showBackButton
        ? Container(
            // margin: const EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(12),
            //   border: Border.all(width: 2.5, color: AppColors.colorFormTitleBg),
            // ),
            child: InkWell(
              hoverColor: Colors.transparent,
              highlightColor: const Color.fromARGB(0, 112, 96, 96),
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
              // child: Container(
              //   height: 20,
              //   width: 20,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       color: const Color(0xffF7F7F7)),
              //   child: const Center(
              //     child: Icon(
              //       Icons.arrow_back_ios_rounded,
              //       color: AppColors.colorBlack,
              //     ),
              //   ),
              // ),
              child: const Icon(
                Icons.arrow_left,
                color: Colors.black,
                size: 35,
              ),
            ),
          )
        : null,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              // 'Add Store',
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
                // height: 0.05,
              ),
            ),
          ),
          const SizedBox(width: 20),
          assetImagePath != null
              ? Image.asset(assetImagePath, height: 50)
              : Container(),
        ],
      ),
    ),
    actions: [action ?? Container()],
  );
}
