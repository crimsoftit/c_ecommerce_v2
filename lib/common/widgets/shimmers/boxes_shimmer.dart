import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CBoxesShimmer extends StatelessWidget {
  const CBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CShimmerEffect(
                width: 150.0,
                height: 110.0,
              ),
            ),
            SizedBox(
              width: CSizes.spaceBtnItems,
            ),
            Expanded(
              child: CShimmerEffect(
                width: 150.0,
                height: 110.0,
              ),
            ),
            SizedBox(
              width: CSizes.spaceBtnItems,
            ),
            Expanded(
              child: CShimmerEffect(
                width: 150.0,
                height: 110.0,
              ),
            ),
            SizedBox(
              width: CSizes.spaceBtnItems,
            ),
          ],
        ),
      ],
    );
  }
}
