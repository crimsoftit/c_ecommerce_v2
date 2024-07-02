import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CListTileShimmer extends StatelessWidget {
  const CListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            CShimmerEffect(
              width: 50.0,
              height: 50.0,
              radius: 50.0,
            ),
            SizedBox(
              width: CSizes.spaceBtnItems,
            ),
            Column(
              children: [
                CShimmerEffect(
                  width: 100.0,
                  height: 15.0,
                ),
                SizedBox(
                  height: CSizes.spaceBtnItems,
                ),
                CShimmerEffect(
                  width: 80.0,
                  height: 12.0,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
