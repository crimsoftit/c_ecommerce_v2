import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:duara_ecommerce/features/shop/screens/p_reviews/widgets/rating_progress_indicator.dart';
import 'package:duara_ecommerce/features/shop/screens/p_reviews/widgets/user_reviews_card.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      // -- appBar --
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'ratings & reviews',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      // -- body --
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'our ratings and reviews are thoroughly vetted and verified from all people who use the same type of device as yours',
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // -- overall product ratings
              const COverallProductRating(),

              // -- rating bar indicator
              const CRatingBarIndicator(
                rating: 3.5,
                iconColor: CColors.rBrown,
              ),
              Text(
                '10,401 reviews',
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: CColors.darkGrey,
                    ),
              ),
              const SizedBox(
                height: CSizes.spaceBtnSections,
              ),

              // -- users' reviews list
              const UserReviewsCard(),
              const UserReviewsCard(),
              const UserReviewsCard(),
              const UserReviewsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
