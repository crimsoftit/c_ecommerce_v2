import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/features/personalization/controllers/addresses_controller.dart';
import 'package:duara_ecommerce/features/personalization/models/addresses_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CSingleAddress extends StatelessWidget {
  const CSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final CAddressesModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final addressesController = CAddressesController.instance;

    return Obx(
      () {
        final selectedAddressId = addressesController.selectedAddress.value.id;

        final selectedAddress = selectedAddressId == address.id;

        return InkWell(
          onTap: onTap,
          child: CRoundedContainer(
            width: double.infinity,
            showBorder: true,
            padding: const EdgeInsets.all(CSizes.md),
            bgColor: selectedAddress
                ? CColors.rBrown.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : isDarkTheme
                    ? CColors.darkerGrey
                    : CColors.grey,
            margin: const EdgeInsets.only(
              bottom: CSizes.spaceBtnItems,
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 5.0,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? isDarkTheme
                            ? CColors.light
                            : CColors.rBrown
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: selectedAddress
                          ? Theme.of(context).textTheme.titleMedium!.apply(
                                fontSizeFactor: 0.8,
                              )
                          : Theme.of(context).textTheme.titleSmall!.apply(
                                color: CColors.darkGrey,
                                fontSizeFactor: 0.8,
                              ),
                    ),
                    const SizedBox(
                      height: CSizes.sm / 2,
                    ),
                    Text(
                      address.phoneNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: selectedAddress
                          ? Theme.of(context).textTheme.titleMedium!.apply(
                                fontSizeFactor: 0.8,
                              )
                          : Theme.of(context).textTheme.titleSmall!.apply(
                                color: CColors.darkGrey,
                                fontSizeFactor: 0.8,
                              ),
                    ),
                    const SizedBox(
                      height: CSizes.sm / 2,
                    ),
                    Text(
                      address.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: selectedAddress
                          ? Theme.of(context).textTheme.titleMedium!.apply(
                                fontSizeFactor: 0.8,
                              )
                          : Theme.of(context).textTheme.titleSmall!.apply(
                                color: CColors.darkGrey,
                                fontSizeFactor: 0.8,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
