import 'package:duara_ecommerce/features/shop/screens/p_reviews/widgets/progress_indicator_n_rating.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class COverallProductRating extends StatelessWidget {
  const COverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            '3.5',
            style: Theme.of(context).textTheme.displayLarge!.apply(
                  color: CColors.rBrown,
                  fontSizeFactor: 0.8,
                ),
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              CRatingProgressIndicator(
                txt: '5',
                value: 1.0,
              ),
              CRatingProgressIndicator(
                txt: '4',
                value: 0.8,
              ),
              CRatingProgressIndicator(
                txt: '3',
                value: 0.6,
              ),
              CRatingProgressIndicator(
                txt: '2',
                value: 0.4,
              ),
              CRatingProgressIndicator(
                txt: '1',
                value: 0.2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
