// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class UploadDocWidget extends StatefulWidget {
//   UploadDocWidget(
//       {super.key,
//       this.clearImage,
//       this.alreadyUrlExists,
//       this.reset = false, // default to false
//       required this.title,
//       required this.getUrl,
//       required this.folderName,
//       isLoading = false,
//       this.width,
//       this.fieldKey,
//       this.isSquareShape = false});

//   String title;
//   bool? clearImage;
//   String? alreadyUrlExists;
//   final bool reset;
//   Key? fieldKey;
//   Function(
//     String value,
//   ) getUrl;
//   String? folderName = 'DefaultFolderName';
//   bool isSquareShape;
//   bool? isLoading;
//   final double? width;
//   @override
//   State<UploadDocWidget> createState() => _UploadDocWidgetState();
// }

// class _UploadDocWidgetState extends State<UploadDocWidget> {
//   File? _selectedImage;
//   bool? _isLoading;

//   String? url;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.alreadyUrlExists != null &&
//         widget.alreadyUrlExists!.isNotEmpty) {
//       url = widget.alreadyUrlExists;
//     }
//   }

//   // @override
//   // void didUpdateWidget(covariant UploadDocWidget oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   if (widget.alreadyUrlExists != oldWidget.alreadyUrlExists) {
//   //     if (widget.alreadyUrlExists != null &&
//   //         widget.alreadyUrlExists!.isNotEmpty) {
//   //       setState(() {
//   //         url = widget.alreadyUrlExists;
//   //         _selectedImage = null;
//   //       });
//   //     } else {
//   //       _resetImage();
//   //     }
//   //   }
//   //   if (widget.reset && !oldWidget.reset) {
//   //     _resetImage();
//   //   }
//   // }
//   @override
//   void didUpdateWidget(covariant UploadDocWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.alreadyUrlExists != oldWidget.alreadyUrlExists &&
//         widget.alreadyUrlExists != null &&
//         widget.alreadyUrlExists!.isNotEmpty &&
//         widget.alreadyUrlExists != url) {
//       setState(() {
//         url = widget.alreadyUrlExists;
//         _selectedImage = null;
//       });
//     }

//     if (widget.reset && !oldWidget.reset) {
//       _resetImage();
//     }
//   }

//   void _resetImage() {
//     setState(() {
//       _selectedImage = null;
//       url = null;
//       widget.getUrl('');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if (widget.alreadyUrlExists?.isNotEmpty ?? false) {
//     //   url = widget.alreadyUrlExists ?? '';
//     // }
//     // print('this is the selected image $_selectedImage');
//     bool isSquareShape = widget.isSquareShape;
//     // if (widget.clearImage == true) {
//     //   _selectedImage = null;
//     //   widget.getUrl('');
//     // }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
//       child: DottedBorder(
//         // borderType: BorderType.RRect,
//         // radius: const Radius.circular(15),
//         // // color: AppColors.colorSecondaryPurple,
//         // color: const Color(0xffE7E7E7),
//         // strokeWidth: 1.3,
//         // dashPattern: isSquareShape ? [6, 4] : const [3, 4],
//         options: RoundedRectDottedBorderOptions(
//           radius: const Radius.circular(15),
//           // color: AppColors.colorInactivecContainerBg,
//           strokeWidth: 1.3,
//           dashPattern: widget.isSquareShape ? [6, 4] : const [3, 4],
//         ),
//         child: ClipRRect(
//           key: widget.fieldKey,
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//               // color: AppColors.bgColor,
//               width: widget.width ?? Get.width,
//               height: isSquareShape ? 80 : 140,
//               child: _selectedImage != null || (url?.isNotEmpty ?? false)
//                   ? Container(
//                       width: Get.width,
//                       // color: AppColors.colorWhite,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Center(
//                                 child: (url?.isNotEmpty ?? false)
//                                     ? url!.toLowerCase().endsWith('.pdf')
//                                         ? Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               const Icon(Icons.file_copy_sharp),
//                                               const Gap(4),
//                                               Text(
//                                                 url.toString().split('/').last,
//                                                 style: const TextStyle(
//                                                   // color: AppColors.colorBlack,
//                                                   fontSize: 12,
//                                                   fontFamily: 'Gilroy',
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         : Image.network(
//                                             url ?? '',
//                                             height: 120,
//                                             width: Get.width,
//                                             fit: BoxFit.contain,
//                                           )
//                                     : Container(
//                                         child: const Icon(Icons.image),
//                                       )),
//                           ),
//                           Positioned(
//                             top: 8,
//                             right: 10,
//                             child: InkWell(
//                                 onTap: () {
//                                   _resetImage();
//                                 },
//                                 child: Icon(Icons.delete)
//                                 // Image.asset(
//                                 //   trashIcon,
//                                 //   height: 20,
//                                 // )
//                                 ),
//                           )
//                         ],
//                       ),
//                     )
//                   : isSquareShape
//                       ? InkWell(
//                           key: widget.fieldKey,
//                           onTap: () async {
//                             // Close the keyboard
//                             FocusScope.of(context).unfocus();
//                             if (GlobalMethods().isIOSBrowser()) {
//                               Get.bottomSheet(
//                                 _buildDocumentTypeBottomSheet(),
//                                 backgroundColor:
//                                     CupertinoColors.systemGroupedBackground,
//                                 isScrollControlled: true,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(20)),
//                                 ),
//                               ).then((v) async {
//                                 if (v != null) {
//                                   if (v == 'Image') {
//                                     await GlobalMethods.pickImageFromGallery()
//                                         .then((file) {
//                                       setState(() {
//                                         _isLoading =
//                                             true; // Show loader when tapping
//                                       });
//                                       if (file != null) {
//                                         Get.find<ApiClient>()
//                                             .uploadFile(
//                                                 file: file,
//                                                 folderName:
//                                                     widget.folderName ?? '')
//                                             .then((linkUrl) {
//                                           print(
//                                               'this is the url from backend $linkUrl');
//                                           widget.getUrl(linkUrl ?? '');
//                                           if (linkUrl != null) {
//                                             setState(() {
//                                               _selectedImage = File(file.path);
//                                               url = linkUrl ?? '';
//                                               _isLoading =
//                                                   false; // Hide loader after successful upload
//                                             });
//                                           } else {
//                                             setState(() {
//                                               _isLoading =
//                                                   false; // Hide loader on upload error
//                                             });
//                                           }
//                                         });
//                                       } else {
//                                         setState(() {
//                                           _isLoading =
//                                               false; // Hide loader on upload error
//                                         });
//                                       }
//                                     });
//                                   } else if (v == 'PDF') {
//                                     await GlobalMethods()
//                                         .pickPDFDocument()
//                                         .then((result) async {
//                                       if (result != null) {
//                                         setState(() {
//                                           _isLoading =
//                                               true; // Show loader when tapping
//                                         });
//                                         dio.MultipartFile file;
//                                         String fileName =
//                                             result.files.first.name;

//                                         // Handle Web and Mobile
//                                         if (kIsWeb) {
//                                           Uint8List fileBytes =
//                                               result.files.first.bytes!;
//                                           file = dio.MultipartFile.fromBytes(
//                                               fileBytes,
//                                               filename: fileName);
//                                         } else {
//                                           io.File pickedFile =
//                                               io.File(result.files.first.path!);
//                                           file =
//                                               await dio.MultipartFile.fromFile(
//                                             pickedFile.path,
//                                             filename: fileName,
//                                           );
//                                         }

//                                         // Upload PDF

//                                         await Get.find<ApiClient>()
//                                             .uploadPdfFile(
//                                           file: file,
//                                           folderName: widget.folderName ?? '',
//                                         )
//                                             .then((linkUrl) {
//                                           widget.getUrl(linkUrl ?? '');
//                                           if (linkUrl != null) {
//                                             setState(() {
//                                               url = linkUrl;
//                                               _isLoading =
//                                                   false; // Hide loader after successful upload
//                                             });
//                                           } else {
//                                             setState(() {
//                                               _isLoading =
//                                                   false; // Hide loader on upload error
//                                             });
//                                           }
//                                           return null;
//                                         });
//                                       } else {
//                                         throw Exception('No file selected.');
//                                       }
//                                     });
//                                   }
//                                 } else {
//                                   print('No file type selected');
//                                 }
//                               });
//                             } else {
//                               await GlobalMethods()
//                                   .pickDocumentFile()
//                                   .then((result) async {
//                                 if (result != null) {
//                                   setState(() {
//                                     _isLoading =
//                                         true; // Show loader when tapping
//                                   });
//                                   dio.MultipartFile file;
//                                   String fileName = result.files.first.name;

//                                   // Handle Web and Mobile
//                                   if (kIsWeb) {
//                                     Uint8List fileBytes =
//                                         result.files.first.bytes!;
//                                     file = dio.MultipartFile.fromBytes(
//                                         fileBytes,
//                                         filename: fileName);
//                                   } else {
//                                     io.File pickedFile =
//                                         io.File(result.files.first.path!);
//                                     file = await dio.MultipartFile.fromFile(
//                                       pickedFile.path,
//                                       filename: fileName,
//                                     );
//                                   }

//                                   // Upload PDF
//                                   await Get.find<ApiClient>()
//                                       .uploadPdfFile(
//                                     file: file,
//                                     folderName: widget.folderName ?? '',
//                                   )
//                                       .then((linkUrl) {
//                                     widget.getUrl(linkUrl ?? '');
//                                     if (linkUrl != null) {
//                                       setState(() {
//                                         url = linkUrl;
//                                         _isLoading =
//                                             false; // Hide loader after successful upload
//                                       });
//                                     } else {
//                                       setState(() {
//                                         _isLoading =
//                                             false; // Hide loader on upload error
//                                       });
//                                     }
//                                     return null;
//                                   });
//                                 } else {
//                                   // throw Exception('No file selected.');
//                                 }
//                               });
//                             }

//                             //  await partnerController
//                             //     .pickImageFromGallery()
//                             //     .then((file) {
//                             //   setState(() {
//                             //     _isLoading = true; // Show loader when tapping
//                             //   });
//                             //   if (file != null) {
//                             //     Get.find<ApiClient>()
//                             //         .uploadFile(
//                             //             file: file,
//                             //             folderName:
//                             //                 widget.folderName ?? 'pancard')
//                             //         .then((linkUrl) {
//                             //       print(
//                             //           'this is the url from backend $linkUrl');
//                             //       widget.getUrl(linkUrl ?? '');
//                             //       if (linkUrl != null) {
//                             //         setState(() {
//                             //           _selectedImage = File(file.path);
//                             //           url = linkUrl ?? '';
//                             //           _isLoading =
//                             //               false; // Hide loader after successful upload
//                             //         });
//                             //       } else {
//                             //         setState(() {
//                             //           _isLoading =
//                             //               false; // Hide loader on upload error
//                             //         });
//                             //       }
//                             //     });
//                             //   } else {
//                             //     setState(() {
//                             //       _isLoading =
//                             //           false; // Hide loader on upload error
//                             //     });
//                             //   }
//                             // });
//                           },
//                           child: _isLoading ?? false
//                               ? Center(
//                                   child:
//                                       LoadingAnimationWidget.staggeredDotsWave(
//                                           color: AppColors.colorBlack,
//                                           size: 30))
//                               : Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       Upload_fill,
//                                       color: AppColors.colortextGrey2,
//                                       height: 20,
//                                     ).paddingSymmetric(vertical: 0),
//                                     const SizedBox(
//                                       height: 4,
//                                     ),
//                                     Container(
//                                       // margin: const EdgeInsets.symmetric(horizontal: 4),
//                                       // decoration: const BoxDecoration(
//                                       //     border: Border(
//                                       //         bottom: BorderSide(
//                                       //   color: AppColors.colorSecondaryPurple,
//                                       //   width: 1.0, // Underline thickness
//                                       // ))),
//                                       child: FittedBox(
//                                         child: Text(
//                                           widget.title,
//                                           style: const TextStyle(
//                                               fontFamily: 'Gilroy',
//                                               color:
//                                                   AppColors.colortextDarkGrey,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                     ).paddingSymmetric(
//                                         vertical: 0, horizontal: 4),

//                                     // Container(
//                                     //   padding: const EdgeInsets.all(4),
//                                     //   clipBehavior: Clip.antiAlias,
//                                     //   decoration: ShapeDecoration(
//                                     //     color: AppColors.bgColor,
//                                     //     shape: RoundedRectangleBorder(
//                                     //         borderRadius:
//                                     //             BorderRadius.circular(4)),
//                                     //     shadows: const [
//                                     //       BoxShadow(
//                                     //         color: Color(0xFFFFFFFF),
//                                     //         blurRadius: 10,
//                                     //         offset: Offset(-5, -5),
//                                     //         spreadRadius: 0,
//                                     //       ),
//                                     //       BoxShadow(
//                                     //         color: Color(0x7FAAAACC),
//                                     //         blurRadius: 10,
//                                     //         offset: Offset(5, 5),
//                                     //         spreadRadius: 0,
//                                     //       )
//                                     //     ],
//                                     //   ),
//                                     //   child: IconButton(
//                                     //     icon: const Icon(Icons.camera_alt),
//                                     //     onPressed: () async {
//                                     //       await authController
//                                     //           .captureImage()
//                                     //           .then((value) {
//                                     //         setState(() {
//                                     //           _selectedImage = value;
//                                     //         });
//                                     //       });
//                                     //     },
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                         )

//                       //~~~~~~~~~~~~~~~start of square shape widget~~~~~~~~~~~~~~~~~~~~~~
//                       //  InkWell(
//                       //     onTap: () async {
//                       //       FocusScope.of(context).unfocus();

//                       //       await GlobalMethods.pickImageFromGallery()
//                       //           .then((file) {
//                       //         setState(() {
//                       //           _isLoading = true; // Show loader when tapping
//                       //         });
//                       //         if (file != null) {
//                       //           Get.find<ApiClient>()
//                       //               .uploadFile(
//                       //                   file: file,
//                       //                   folderName:
//                       //                       widget.folderName ?? 'pancard')
//                       //               .then((linkUrl) {
//                       //             // print('this is the url from backend $linkUrl');
//                       //             widget.getUrl(linkUrl ?? '');
//                       //             if (linkUrl != null) {
//                       //               setState(() {
//                       //                 _selectedImage = File(file.path);
//                       //                 url = linkUrl ?? '';
//                       //                 _isLoading =
//                       //                     false; // Hide loader after successful upload
//                       //               });
//                       //             } else {
//                       //               setState(() {
//                       //                 _isLoading =
//                       //                     false; // Hide loader on upload error
//                       //               });
//                       //             }
//                       //           });
//                       //         } else {
//                       //           setState(() {
//                       //             _isLoading =
//                       //                 false; // Hide loader on upload error
//                       //           });
//                       //         }
//                       //       });
//                       //     },
//                       //     child: _isLoading ?? false
//                       //         ? Center(
//                       //             child: LoadingAnimationWidget.staggeredDotsWave(
//                       //                 color: AppColors.colorSecondaryPurple,
//                       //                 size: 50))
//                       //         : Column(
//                       //             mainAxisAlignment: MainAxisAlignment.center,
//                       //             children: [
//                       //               Image.asset(
//                       //                 Upload_fill,
//                       //                 color: AppColors.colorSecondaryPurple,
//                       //                 height: 20,
//                       //               ).paddingSymmetric(vertical: 0),
//                       //               const SizedBox(
//                       //                 height: 4,
//                       //               ),
//                       //               Container(
//                       //                 // margin: const EdgeInsets.symmetric(horizontal: 4),
//                       //                 decoration: const BoxDecoration(
//                       //                     border: Border(
//                       //                         bottom: BorderSide(
//                       //                   color: AppColors.colorSecondaryPurple,
//                       //                   width: 1.0, // Underline thickness
//                       //                 ))),
//                       //                 child: FittedBox(
//                       //                   child: Text(
//                       //                     widget.title,
//                       //                     style: const TextStyle(
//                       //                       fontFamily: 'Gilroy',
//                       //                       color: AppColors.colorSecondaryPurple,
//                       //                       fontSize: 12,
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //               ).paddingSymmetric(
//                       //                   vertical: 0, horizontal: 4),

//                       //               // Container(
//                       //               //   padding: const EdgeInsets.all(4),
//                       //               //   clipBehavior: Clip.antiAlias,
//                       //               //   decoration: ShapeDecoration(
//                       //               //     color: AppColors.bgColor,
//                       //               //     shape: RoundedRectangleBorder(
//                       //               //         borderRadius:
//                       //               //             BorderRadius.circular(4)),
//                       //               //     shadows: const [
//                       //               //       BoxShadow(
//                       //               //         color: Color(0xFFFFFFFF),
//                       //               //         blurRadius: 10,
//                       //               //         offset: Offset(-5, -5),
//                       //               //         spreadRadius: 0,
//                       //               //       ),
//                       //               //       BoxShadow(
//                       //               //         color: Color(0x7FAAAACC),
//                       //               //         blurRadius: 10,
//                       //               //         offset: Offset(5, 5),
//                       //               //         spreadRadius: 0,
//                       //               //       )
//                       //               //     ],
//                       //               //   ),
//                       //               //   child: IconButton(
//                       //               //     icon: const Icon(Icons.camera_alt),
//                       //               //     onPressed: () async {
//                       //               //       await authController
//                       //               //           .captureImage()
//                       //               //           .then((value) {
//                       //               //         setState(() {
//                       //               //           _selectedImage = value;
//                       //               //         });
//                       //               //       });
//                       //               //     },
//                       //               //   ),
//                       //               // ),
//                       //             ],
//                       //           ),
//                       //   )

//                       //~~~~~~~~~~~~~~~start of square shape widget~~~~~~~~~~~~~~~~~~~~~~

//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             widget.isLoading ?? false
//                                 ? Center(
//                                     child: LoadingAnimationWidget
//                                         .staggeredDotsWave(
//                                             color: AppColors.colorBlack,
//                                             size: 50))
//                                 : DottedBorder(
//                                     // borderType: BorderType.Circle,
//                                     // color: AppColors.colorPrimary,
//                                     // strokeWidth: 3.0,
//                                     // dashPattern: const [3, 4],
//                                     options: RoundedRectDottedBorderOptions(
//                                       radius: const Radius.circular(15),
//                                       color: AppColors.colortextGrey2,
//                                       strokeWidth: 3.0,
//                                       dashPattern: const [3, 4],
//                                     ),
//                                     child: Container(
//                                       height: 60,
//                                       width: 60,
//                                       margin: const EdgeInsets.all(4),
//                                       decoration: const BoxDecoration(
//                                           color: AppColors.colorPrimary,
//                                           shape: BoxShape.circle),
//                                       padding: const EdgeInsets.all(4),
//                                       child: IconButton(
//                                         icon: const Icon(
//                                           Icons.cloud_upload,
//                                           color: AppColors.colorWhite,
//                                           size: 30,
//                                         ),
//                                         onPressed: () async {
//                                           await GlobalMethods
//                                                   .pickImageFromGallery()
//                                               .then((file) {
//                                             if (file != null) {
//                                               Get.find<ApiClient>()
//                                                   .uploadFile(
//                                                       file: file,
//                                                       folderName:
//                                                           widget.folderName ??
//                                                               'folder')
//                                                   .then((linkUrl) {
//                                                 // print("this is the url $linkUrl");
//                                                 widget.getUrl(linkUrl ?? '');
//                                                 // print('url : $linkUrl');
//                                                 if (linkUrl != null) {
//                                                   setState(() {
//                                                     url = linkUrl;
//                                                     _selectedImage =
//                                                         File(file.path);
//                                                   });
//                                                 }
//                                               });
//                                             }
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ).paddingSymmetric(vertical: 4),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               // margin: const EdgeInsets.symmetric(horizontal: 4),
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(
//                                 color: AppColors.colorPrimary,
//                                 width: 1.0, // Underline thickness
//                               ))),
//                               child: FittedBox(
//                                 child: Text(
//                                   widget.title,
//                                   style: const TextStyle(
//                                     color: AppColors.colorPrimary,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ).paddingSymmetric(vertical: 4, horizontal: 4)
//                             // Container(
//                             //   padding: const EdgeInsets.all(4),
//                             //   clipBehavior: Clip.antiAlias,
//                             //   decoration: ShapeDecoration(
//                             //     color: AppColors.bgColor,
//                             //     shape: RoundedRectangleBorder(
//                             //         borderRadius:
//                             //             BorderRadius.circular(4)),
//                             //     shadows: const [
//                             //       BoxShadow(
//                             //         color: Color(0xFFFFFFFF),
//                             //         blurRadius: 10,
//                             //         offset: Offset(-5, -5),
//                             //         spreadRadius: 0,
//                             //       ),
//                             //       BoxShadow(
//                             //         color: Color(0x7FAAAACC),
//                             //         blurRadius: 10,
//                             //         offset: Offset(5, 5),
//                             //         spreadRadius: 0,
//                             //       )
//                             //     ],
//                             //   ),
//                             //   child: IconButton(
//                             //     icon: const Icon(Icons.camera_alt),
//                             //     onPressed: () async {
//                             //       await authController
//                             //           .captureImage()
//                             //           .then((value) {
//                             //         setState(() {
//                             //           _selectedImage = value;
//                             //         });
//                             //       });
//                             //     },
//                             //   ),
//                             // ),
//                           ],
//                         )

//               // ListView.builder(
//               //   itemCount: widget.itemList.length,
//               //   itemBuilder: (context, index) {
//               //     final item = widget.itemList[index];
//               //     return ListTile(
//               //       title: Text(item),
//               //       onTap: () {
//               //         setState(() {
//               //           _selectedItem = item;
//               //           if (widget.isFirmType) {
//               //             authcont.setFirmType(item);
//               //           }
//               //           _isOpen = false;
//               //         });
//               //       },
//               //     );
//               // },
//               // ),
//               ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDocumentTypeBottomSheet() {
//     final List<String> documentTypes = [
//       'Image',
//       'PDF',
//     ];

//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 5,
//             width: 40,
//             margin: const EdgeInsets.only(top: 8, bottom: 16),
//             decoration: BoxDecoration(
//               color: CupertinoColors.tertiarySystemFill,
//               borderRadius: BorderRadius.circular(2.5),
//             ),
//           ),
//           const Text(
//             'Select Document Type',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Gilroy',
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Divider(
//               height: 1, thickness: 1, color: CupertinoColors.separator),
//           ...documentTypes.map((type) {
//             return CupertinoButton(
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//               onPressed: () {
//                 Get.back(result: type);
//               },
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   type,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: CupertinoColors.black,
//                     fontFamily: 'Gilroy',
//                   ),
//                 ),
//               ),
//             );
//           }),
//           const Divider(
//               height: 1, thickness: 1, color: CupertinoColors.separator),
//           CupertinoButton(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//             onPressed: () {
//               Get.back(); // Close the sheet
//             },
//             child: const Text(
//               'Cancel',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Gilroy',
//                 color: CupertinoColors.destructiveRed,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io' show File;
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocWidget extends StatefulWidget {
  final String title;
  final Function(String value) getUrl;
  final bool isSquareShape;
  final double? width;

  const UploadDocWidget({
    super.key,
    required this.title,
    required this.getUrl,
    this.isSquareShape = true,
    this.width,
  });

  @override
  State<UploadDocWidget> createState() => _UploadDocWidgetState();
}

class _UploadDocWidgetState extends State<UploadDocWidget> {
  String? selectedPath;

  // Future<void> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     setState(() {
  //       selectedPath = image.path;
  //     });

  //     widget.getUrl(image.path);
  //   }
  // }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedPath = image.path;
      });

      widget.getUrl(image.path);
    }
  }

  // Future<void> pickPDF() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     setState(() {
  //       selectedPath = result.files.single.path!;
  //     });

  //     widget.getUrl(result.files.single.path!);
  //   }
  // }

  // void showPickerOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) => SafeArea(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ListTile(
  //             leading: const Icon(Icons.image),
  //             title: const Text("Image"),
  //             onTap: () {
  //               Navigator.pop(context);
  //               pickImage();
  //             },
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.picture_as_pdf),
  //             title: const Text("PDF"),
  //             onTap: () {
  //               Navigator.pop(context);
  //               pickPDF();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Future<void> showPickerOptions() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void resetFile() {
    setState(() {
      selectedPath = null;
    });
    widget.getUrl('');
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      dashPattern: widget.isSquareShape ? [6, 4] : [3, 4],
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.isSquareShape ? 120 : 150,
        padding: const EdgeInsets.all(12),
        child: selectedPath != null
            ? Stack(
                children: [
                  Center(
                    child: kIsWeb
                        ? Image.network(selectedPath!, fit: BoxFit.contain)
                        : Image.file(File(selectedPath!), fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: resetFile,
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: showPickerOptions,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload, size: 35),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
      ),
      //      Container(
      //       width: widget.width ?? double.infinity,
      //       height: widget.isSquareShape ? 120 : 150,
      //       padding: const EdgeInsets.all(12),
      //       child: selectedPath != null
      //           ? Stack(
      //               children: [
      //                 Center(
      //                   child: selectedPath!.toLowerCase().endsWith('.pdf')
      //                       ? Center(
      // child: kIsWeb
      //     ? Image.network(
      //         selectedPath!,
      //         fit: BoxFit.contain,
      //       )
      //     : Image.file(
      //         File(selectedPath!),
      //         fit: BoxFit.contain,
      //       ),
      //                       )),
      //                       // Column(
      //                       //     mainAxisAlignment: MainAxisAlignment.center,
      //                       //     children: [
      //                       //       const Icon(Icons.picture_as_pdf, size: 40),
      //                       //       const SizedBox(height: 8),
      //                       //       Text(
      //                       //         selectedPath!.split('/').last,
      //                       //         style: const TextStyle(fontSize: 12),
      //                       //         textAlign: TextAlign.center,
      //                       //       ),
      //                       //     ],
      //                       //   )
      //                       // : kIsWeb
      //                       // ? Image.network(selectedPath!, fit: BoxFit.contain)
      //                       // : Image.file(File(selectedPath!), fit: BoxFit.contain),

      //                 Positioned(
      //                   top: 0,
      //                   right: 0,
      //                   child: IconButton(
      //                     icon: const Icon(Icons.delete, color: Colors.red),
      //                     onPressed: resetFile,
      //                   ),
      //                 ),
      //               ],
      //             )
      //           : InkWell(
      //               onTap: showPickerOptions,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   const Icon(Icons.cloud_upload, size: 35),
      //                   const SizedBox(height: 8),
      //                   Text(
      //                     widget.title,
      //                     style: const TextStyle(fontWeight: FontWeight.w600),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //     ),
    );
  }
}

// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadDocWidget extends StatefulWidget {
//   final String title;
//   final Function(String value) getUrl;
//   final bool isSquareShape;
//   final double? width;

//   const UploadDocWidget({
//     super.key,
//     required this.title,
//     required this.getUrl,
//     this.isSquareShape = true,
//     this.width,
//   });

//   @override
//   State<UploadDocWidget> createState() => _UploadDocWidgetState();
// }

// class _UploadDocWidgetState extends State<UploadDocWidget> {
//   File? selectedFile;
//   bool isLoading = false;

//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         selectedFile = File(image.path);
//       });
//       widget.getUrl(image.path);
//     }
//   }

//   Future<void> pickPDF() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//       widget.getUrl(result.files.single.path!);
//     }
//   }

//   void showPickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.image),
//               title: const Text("Image"),
//               onTap: () {
//                 Navigator.pop(context);
//                 pickImage();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.picture_as_pdf),
//               title: const Text("PDF"),
//               onTap: () {
//                 Navigator.pop(context);
//                 pickPDF();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void resetFile() {
//     setState(() {
//       selectedFile = null;
//     });
//     widget.getUrl('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DottedBorder(
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(15),
//       dashPattern: widget.isSquareShape ? [6, 4] : [3, 4],
//       child: Container(
//         width: widget.width ?? double.infinity,
//         height: widget.isSquareShape ? 100 : 150,
//         padding: const EdgeInsets.all(12),
//         child: selectedFile != null
//             ? Stack(
//                 children: [
//                   Center(
//                     child: selectedFile!.path.toLowerCase().endsWith('.pdf')
//                         ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(Icons.picture_as_pdf, size: 40),
//                               const SizedBox(height: 8),
//                               Text(
//                                 selectedFile!.path.split('/').last,
//                                 style: const TextStyle(fontSize: 12),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           )
//                         : Image.network(selectedFile!, fit: BoxFit.contain),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: resetFile,
//                     ),
//                   ),
//                 ],
//               )
//             : InkWell(
//                 onTap: showPickerOptions,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.cloud_upload, size: 35),
//                     const SizedBox(height: 8),
//                     Text(
//                       widget.title,
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
