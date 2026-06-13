import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fintrix/common/appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    return Scaffold(
      appBar: appBarWidget('View Image'),
      body: SafeArea(
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 50),
                  imageBuilder: (context, imageProvider) {
                    return PhotoView(
                      imageProvider: imageProvider,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    );
                  },
                )
              : PhotoView(
                  imageProvider: kIsWeb
                      ? NetworkImage(imageUrl)
                      : FileImage(File(imageUrl)) as ImageProvider,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
