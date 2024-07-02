import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CCatogoriesShimmerLoader extends StatelessWidget {
  const CCatogoriesShimmerLoader({
    super.key,
    this.itemCount = 8,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: CSizes.spaceBtnItems,
          );
        },
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- product image
              CShimmerEffect(
                width: 55.0,
                height: 55.0,
                radius: 55.0,
              ),
              SizedBox(
                height: CSizes.spaceBtnItems / 2,
              ),

              // -- text
              CShimmerEffect(
                width: 55.0,
                height: 8.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
