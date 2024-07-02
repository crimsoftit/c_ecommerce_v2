import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_circular_img.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/c_brand_title_with_verified_icon.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/p_price_txt.dart';
import 'package:duara_ecommerce/common/widgets/text_widgets/product_title_texts.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/products_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/enums.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = CProductsController.instance;

    final discount = productController.calculateDiscountPercentage(
        product.pPrice, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- price & sale tag
        Row(
          children: [
            // sale tag
            CRoundedContainer(
              radius: CSizes.sm,
              bgColor: CColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: CSizes.sm,
                vertical: CSizes.xs,
              ),
              child: Text(
                '$discount%',
                style: Theme.of(context).textTheme.labelSmall!.apply(
                      color: CColors.rBrown,
                      //fontSizeFactor: 0.7,
                    ),
              ),
            ),

            const SizedBox(
              width: CSizes.spaceBtnItems / 1.5,
            ),

            // price
            if (product.productType == CProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                'Ksh.${product.pPrice}',
                style: Theme.of(context).textTheme.labelSmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            if (product.productType == CProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(
                width: CSizes.spaceBtnItems,
              ),
            CProductPriceText(
              price: productController.fetchProductPrice(product),
              isLarge: true,
            ),
          ],
        ),

        const SizedBox(
          height: CSizes.spaceBtnItems / 1.5,
        ),

        // -- title
        CProductTitleText(
          title: product.pName,
        ),

        const SizedBox(
          height: CSizes.spaceBtnItems / 1.5,
        ),

        // -- stock status
        Row(
          children: [
            const CProductTitleText(
              title: 'status',
            ),
            const SizedBox(
              width: CSizes.spaceBtnItems,
            ),
            Text(
              '${productController.checkProductStockStatus(product.stockCount)} (${product.stockCount} available)',
              style: Theme.of(context).textTheme.titleMedium!.apply(
                    fontSizeFactor: 0.7,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtnItems / 1.5,
        ),

        // -- brand
        Row(
          children: [
            CCircularImg(
              img: product.pBrand != null ? product.pBrand!.brandImage : '',
              width: 40.0,
              height: 40.0,
              isNetworkImg: true,
              bgColor: CColors.rBrown,
              overlayColor: CColors.white,
              // overlayColor:
              //     isDarkTheme ? CColors.white : CColors.rBrown.withOpacity(0.2),
            ),
            const SizedBox(
              width: CSizes.spaceBtnItems / 4,
            ),
            CBrandTitleWithVerifiedIcon(
              title: product.pBrand!.brandName,
              brandTxtSize: CTextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
