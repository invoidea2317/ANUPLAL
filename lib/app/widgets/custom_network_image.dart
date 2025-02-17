
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  final double? radius;
  final double? imagePadding;
  const CustomNetworkImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = '', this.radius, this.imagePadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width:width?? Get.size.width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius20)
      ),
      child: CachedNetworkImage(
        imageUrl: image, height: height, width: width, fit: fit,
        placeholder: (context, url) => Padding(
          padding:  EdgeInsets.all(imagePadding ?? 0),
          child: Image.asset(placeholder.isNotEmpty ? placeholder  : Images.icGallery, fit: fit),
        ),
        errorWidget: (context, url, error) => Padding(
          padding:  EdgeInsets.all(imagePadding ?? 0),
          child: Image.asset(placeholder.isNotEmpty ? placeholder  : Images.icGallery, fit: fit),
        ),
      ),
    );
  }
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height ?? 200,
        width: width ?? Get.size.width,
        color: Colors.white,
      ),
    );
  }
}



