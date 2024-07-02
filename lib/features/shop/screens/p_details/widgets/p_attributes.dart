import 'package:duara_ecommerce/common/widgets/chips/c_choice_chip.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/product_title_texts.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/section_headings.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/p_variation_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CProductAttributes extends StatelessWidget {
  const CProductAttributes({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    final variationController = Get.put(CVariationController());

    return Obx(
      () => Column(
        children: [
          // -- selected pricing & description attributes --

          if (variationController.selectedVariation.value.id.isNotEmpty)
            CRoundedContainer(
              padding: const EdgeInsets.all(CSizes.md),
              bgColor: isDarkTheme ? CColors.darkGrey : CColors.grey,
              child: Column(
                children: [
                  // -- title, price, and stock status
                  Row(
                    children: [
                      const CSectionHeading(
                        showActionBtn: false,
                        title: 'variations',
                        btnTitle: '',
                        editFontSize: true,
                        fSize: 10.0,
                      ),
                      const SizedBox(
                        width: CSizes.spaceBtnItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CProductTitleText(
                                title: 'price  :',
                                //smallSize: true,
                              ),
                              const SizedBox(
                                width: CSizes.spaceBtnItems,
                              ),

                              /// -- actual price --
                              if (variationController
                                      .selectedVariation.value.pSalePrice >
                                  0)
                                Text(
                                  variationController
                                      .selectedVariation.value.pPrice
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              const SizedBox(
                                width: CSizes.spaceBtnItems / 4,
                              ),

                              // sale price
                              CProductPriceText(
                                price:
                                    variationController.fetchPVariationPrice(),
                                isLarge: true,
                              ),
                            ],
                          ),

                          // stock status
                          Row(
                            children: [
                              const CProductTitleText(
                                title: 'status:',
                              ),
                              const SizedBox(
                                width: CSizes.spaceBtnItems,
                              ),
                              Text(
                                '${variationController.variationStockStatus.value} (${variationController.selectedVariation.value.stockCount})',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(
                                      fontSizeFactor: 0.7,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  // -- product variation description
                  const SizedBox(
                    height: CSizes.spaceBtnItems,
                  ),
                  CProductTitleText(
                    title: variationController
                            .selectedVariation.value.pDescription ??
                        '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: CSizes.spaceBtnItems,
          ),

          // -- product attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.pAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CSectionHeading(
                        showActionBtn: false,
                        title: attribute.aName ?? '',
                        btnTitle: '',
                        editFontSize: false,
                      ),
                      const SizedBox(
                        height: CSizes.spaceBtnItems / 2,
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.aValues!.map(
                            (aValue) {
                              final isSelected = variationController
                                      .selectedAttributes[attribute.aName] ==
                                  aValue;
                              final aAvailable = variationController
                                  .getAttributesAvailabilityInVariation(
                                      product.pVariations!, attribute.aName!)
                                  .contains(aValue);
                              return CChoiceChip(
                                txt: aValue,
                                selected: isSelected,
                                onSelected: aAvailable
                                    ? (selected) {
                                        if (selected && aAvailable) {
                                          variationController
                                              .onAttributeSelected(
                                                  product,
                                                  attribute.aName ?? '',
                                                  aValue);
                                        }
                                      }
                                    : null,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),

          const SizedBox(
            height: CSizes.spaceBtnSections / 2,
          ),
        ],
      ),
    );
  }
}
