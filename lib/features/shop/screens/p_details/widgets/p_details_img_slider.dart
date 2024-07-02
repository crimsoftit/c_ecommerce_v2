import 'package:cached_network_image/cached_network_image.dart';
import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CProductImgSlider extends StatelessWidget {
  const CProductImgSlider({
    super.key,
    required this.product,
  });

  final CProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final imgController = Get.put(CImagesController());
    final pImages = imgController.fetchAllProductImages(product);

    return CCurvedEdgeWidget(
      child: Container(
        color: isDarkTheme ? CColors.rBrown : CColors.light,
        child: Stack(
          children: [
            // main large image
            SizedBox(
              height: 400.0,
              child: Padding(
                padding: const EdgeInsets.all(CSizes.pImgRadius * 2),
                child: Center(
                  child: Obx(
                    () {
                      final selectedImg =
                          imgController.selectedProductImg.value;

                      return GestureDetector(
                        onTap: () =>
                            imgController.showEnlargedImage(selectedImg),
                        child: CachedNetworkImage(
                          imageUrl: selectedImg,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: CColors.rBrown,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: CSizes.defaultSpace,
              child: SizedBox(
                height: 100.0,
                child: ListView.separated(
                  itemCount: pImages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      width: CSizes.spaceBtnItems,
                    );
                  },
                  itemBuilder: (_, index) {
                    return Obx(
                      () {
                        final selectedImg =
                            imgController.selectedProductImg.value ==
                                pImages[index];

                        return CRoundedImages(
                          width: 100.0,
                          bgColor: isDarkTheme ? CColors.dark : CColors.white,
                          isNetworkImg: true,
                          borderRadius: 100,
                          padding: const EdgeInsets.all(CSizes.sm),
                          imgUrl: pImages[index],
                          border: Border.all(
                            color: selectedImg
                                ? CColors.rBrown
                                : Colors.transparent,
                          ),
                          onPressed: () => imgController
                              .selectedProductImg.value = pImages[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // -- appBar icons --
            CAppBar(
              showBackArrow: true,
              title: Text(
                'product details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
              actions: [
                CFavoriteIcon(
                  productId: product.id,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
