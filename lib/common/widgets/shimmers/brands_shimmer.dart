import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/material.dart';

class CbrandsShimmer extends StatelessWidget {
  const CbrandsShimmer({
    super.key,
    required this.itemCount,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) {
        return const CShimmerEffect(
          width: 300.0,
          height: 80.0,
        );
      },
    );
  }
}
