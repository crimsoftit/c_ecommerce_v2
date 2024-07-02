import 'package:cached_network_image/cached_network_image.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CRoundedImages extends StatelessWidget {
  const CRoundedImages({
    super.key,
    this.width,
    this.height,
    required this.imgUrl,
    this.applyImgRadius = true,
    this.border,
    this.bgColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImg = false,
    this.onPressed,
    this.borderRadius = CSizes.md,
  });

  final double? width, height;
  final String imgUrl;
  final bool applyImgRadius;
  final BoxBorder? border;
  final Color? bgColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImg;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImgRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImg
              ? CachedNetworkImage(
                  imageUrl: imgUrl,
                  progressIndicatorBuilder: (context, url, progress) {
                    return CShimmerEffect(
                      width: width ?? double.infinity,
                      height: height ?? 160,
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(imgUrl),
                ),
        ),
      ),
    );
  }
}
