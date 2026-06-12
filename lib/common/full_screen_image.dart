// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fintrix/common/appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:indilink/Common/Helper/helper.dart';
// import 'package:indilink/Common/customAppbar.dart';
// import 'package:indilink/globals.dart';
// import 'package:indilink/utils/colors.dart';
// import 'package:indilink/utils/imageConstants.dart';
// import 'package:indilink/utils/styles.dart';
// import 'package:photo_view/photo_view.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  // final int navKey;
  const FullScreenImageView({
    super.key,
    required this.imageUrl,
    // required this.navKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('View Image'),
      // appBar: AppBar(
      //   // backgroundColor: AppColors.baseColor,
      //   iconTheme: const IconThemeData(color: Colors.black),
      // ),
      body: SafeArea(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                const CircularProgressIndicator(color: Colors.black),
            errorWidget: (context, url, error) => const Icon(Icons.image),
            imageBuilder: (context, imageProvider) => PhotoView(
              imageProvider: imageProvider,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),

      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   // mainAxisSize: MainAxisSize.min,
      //   children: [
      // Flexible(
      // child: SizedBox(
      //   height: 400,
      //  Center(
      //    child: CachedNetworkImage(
      //     imageUrl: imageUrl,
      //     placeholder: (context, url) => const CircularProgressIndicator(
      //       color: AppColors.colorSecondaryPurple,
      //     ),
      //     errorWidget: (context, url, error) => const Icon(Icons.error),
      //     imageBuilder: (context, imageProvider) => PhotoView(
      //       imageProvider: imageProvider,
      //       backgroundDecoration:
      //           const BoxDecoration(color: AppColors.colorTransparent),
      //     ),
      //                ),
      //  ),
      // ),
      // ),
      // const Gap(10),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      //   child: Align(
      //     alignment: Alignment.bottomRight,
      //     child: InkWell(
      //       hoverColor: AppColors.colorTransparent,
      //       highlightColor: AppColors.colorTransparent,
      //       splashColor: AppColors.colorTransparent,
      //       onTap: () {
      //         if (imageUrl.isNotEmpty) {
      //           GlobalMethods.startDownload(
      //             imageUrl,
      //           );
      //         } else {
      //           ToastService.show('Invalid URL');
      //         }
      //       },
      //       child: Container(
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             color: AppColors.colorSecondaryPurple),
      //         child: Center(
      //           child: Image.asset(
      //             downCloudIcon,
      //             height: 20,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // )
      //   ],
      // ),
    );
  }
}
