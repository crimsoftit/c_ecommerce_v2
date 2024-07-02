import 'package:duara_ecommerce/common/widgets/img_txt_widgets/vertical_img_txt.dart';
import 'package:duara_ecommerce/common/widgets/shimmers/categories_shimmer.dart';
import 'package:duara_ecommerce/features/personalization/screens/no_data/no_data.dart';
import 'package:duara_ecommerce/features/shop/controllers/categories_controller.dart';
import 'package:duara_ecommerce/features/shop/screens/subcategories/subcategories.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CHomeCategories extends StatelessWidget {
  const CHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final catsController = Get.put(CCatsController());

    return Obx(() {
      if (catsController.isLoading.value) {
        return const CCatogoriesShimmerLoader();
      } else {
        if (catsController.featuredCategories.isEmpty) {
          return const Center(
            child: NoDataScreen(
              lottieImage: CImages.noDataLottie,
              txt: 'no data found for categories!',
            ),
          );
        } else {
          return SizedBox(
            height: 100.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: catsController.featuredCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final pCategory = catsController.featuredCategories[index];

                return CVerticalImgTxt(
                  img: pCategory.cImg,
                  title: pCategory.cName,
                  txtColor: CColors.txtWhite,
                  bgColor: CColors.white,
                  isNetworkImage: true,
                  onTap: () {
                    Get.to(
                      () => CSubCategoriesScreen(
                        category: pCategory,
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      }
    });
  }
}
