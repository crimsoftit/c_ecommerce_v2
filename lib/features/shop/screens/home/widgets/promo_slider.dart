// ignore_for_file: unrelated_type_equality_checks

import 'package:carousel_slider/carousel_slider.dart';
import 'package:duara_ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:duara_ecommerce/common/widgets/img_widgets/c_rounded_img.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/banner_controller.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPromoSlider extends StatelessWidget {
  const CPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(CBannerController());

    return Obx(
      () {
        if (bannerController.isLoading.value) {
          return const CShimmerEffect(
            width: double.infinity,
            height: 200.0,
          );
        } else {
          if (bannerController.banners.isEmpty) {
            return const Center(
              child: NoDataScreen(
                lottieImage: CImages.noDataLottie,
                txt: 'No data found!',
              ),
            );
          } else {
            return Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    onPageChanged: (index, _) {
                      bannerController.updatePageIndicator(index);
                    },
                  ),
                  items: bannerController.banners
                      .map((banner) => CRoundedImages(
                            imgUrl: banner.imgUrl,
                            isNetworkImg: true,
                            onPressed: () {
                              Get.toNamed(banner.targetScreen);
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnItems,
                ),
                Center(
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0;
                            i < bannerController.banners.length;
                            i++)
                          CCircularContainer(
                            width: 20.0,
                            height: 4.0,
                            margin: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            bgColor: bannerController.carouselCurrentIndex == i
                                ? CColors.rBrown
                                : CColors.grey,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
