import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class CRatingProgressIndicator extends StatelessWidget {
  const CRatingProgressIndicator({
    super.key,
    required this.txt,
    required this.value,
  });

  final String txt;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            txt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 12,
          child: SizedBox(
            width: CDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11.0,
              backgroundColor: CColors.grey,
              borderRadius: BorderRadius.circular(5),
              valueColor: const AlwaysStoppedAnimation(CColors.rBrown),
            ),
          ),
        ),
      ],
    );
  }
}
