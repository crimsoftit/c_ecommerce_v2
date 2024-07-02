import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class CRatingBarIndicator extends StatelessWidget {
  const CRatingBarIndicator({
    super.key,
    required this.rating,
    required this.iconColor,
  });

  final double rating;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20.0,
      unratedColor: CColors.grey,
      itemBuilder: (_, __) {
        return Icon(
          Iconsax.star1,
          color: iconColor,
        );
      },
    );
  }
}
