import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewsCard extends StatelessWidget {
  const UserReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    CImages.userProfileImg1,
                  ),
                ),
                const SizedBox(
                  width: CSizes.spaceBtnItems,
                ),
                Text(
                  'nucho',
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                        fontSizeFactor: 0.9,
                        fontWeightDelta: 2,
                      ),
                ),
              ],
            ),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems,
        ),

        // -- user's review
        Row(
          children: [
            const CRatingBarIndicator(
              rating: 4.0,
              iconColor: CColors.rBrown,
            ),
            const SizedBox(
              width: CSizes.spaceBtnItems,
            ),
            Text(
              '02 Apr, 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems,
        ),

        ReadMoreText(
          "The app's user interface is quite intuitive. I was able to seamlessly navigate & make my purchases. To the dev team, Kudos!!",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' show more',
          trimExpandedText: ' less',
          moreStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color:
                isDarkTheme ? CColors.rBrown : CColors.rBrown.withOpacity(0.5),
          ),
          lessStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color:
                isDarkTheme ? CColors.rBrown : CColors.rBrown.withOpacity(0.4),
          ),
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems,
        ),

        // -- company review
        CRoundedContainer(
          bgColor: isDarkTheme ? CColors.darkerGrey : CColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(CSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Crimsoft Inc.',
                      style: Theme.of(context).textTheme.titleMedium!.apply(
                            fontSizeFactor: 0.9,
                            fontWeightDelta: 2,
                          ),
                    ),
                    Text(
                      '02 Apr, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems,
                ),
                ReadMoreText(
                  "The app's user interface is quite intuitive. I was able to seamlessly navigate & make my purchases. To the dev team, Kudos!!",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' show more',
                  trimExpandedText: ' less',
                  moreStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: isDarkTheme
                        ? CColors.rBrown
                        : CColors.rBrown.withOpacity(0.5),
                  ),
                  lessStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: isDarkTheme
                        ? CColors.rBrown
                        : CColors.rBrown.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: CSizes.spaceBtnSections,
        ),
      ],
    );
  }
}
