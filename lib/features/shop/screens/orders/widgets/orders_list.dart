import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class COrdersListItems extends StatelessWidget {
  const COrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 16,
      separatorBuilder: (_, __) => const SizedBox(
        height: CSizes.spaceBtnItems,
      ),
      itemBuilder: (_, index) => CRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(CSizes.md),
        bgColor: isDarkTheme ? CColors.dark : CColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // -- 1st Row() --
            Row(
              children: [
                // -- 1. shipment icon
                Icon(
                  Iconsax.ship,
                  color: isDarkTheme ? CColors.grey : CColors.rBrown,
                ),
                const SizedBox(
                  width: CSizes.spaceBtnItems / 2,
                ),

                // -- 2. shipment status & date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'processing',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: CColors.primaryBlue,
                            ),
                      ),
                      Text(
                        '20 Apr, 2024',
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),

                // -- 3. proceed iconButton
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.arrow_right_34,
                    size: CSizes.iconSm,
                    color: isDarkTheme ? CColors.white : CColors.rBrown,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: CSizes.spaceBtnItems,
            ),

            // -- 2nd Row() --
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // -- 1. shipment icon
                      Icon(
                        Iconsax.tag,
                        color: isDarkTheme ? CColors.grey : CColors.rBrown,
                      ),
                      const SizedBox(
                        width: CSizes.spaceBtnItems / 2,
                      ),

                      // -- 2. shipment status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'order id',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '[#256f2]',
                              style:
                                  Theme.of(context).textTheme.labelSmall!.apply(
                                        fontStyle: FontStyle.italic,
                                        color: isDarkTheme
                                            ? CColors.white
                                            : Colors.grey,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // -- 1. shipment icon
                      Icon(
                        Iconsax.calendar,
                        color: isDarkTheme ? CColors.grey : CColors.rBrown,
                      ),
                      const SizedBox(
                        width: CSizes.spaceBtnItems / 2,
                      ),

                      // -- 2. shipment status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'shipping date',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '01 Dec, 2024',
                              style:
                                  Theme.of(context).textTheme.labelSmall!.apply(
                                        fontStyle: FontStyle.italic,
                                        color: isDarkTheme
                                            ? CColors.white
                                            : Colors.grey,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
