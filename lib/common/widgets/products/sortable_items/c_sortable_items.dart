import 'package:duara_ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:duara_ecommerce/common/widgets/products/product_cards/p_card_vert.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/all_products_controller.dart';
import 'package:duara_ecommerce/features/shop/models/product_model.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CSortableItems extends StatelessWidget {
  const CSortableItems({
    super.key,
    required this.allProducts,
  });

  final List<CProductModel> allProducts;

  @override
  Widget build(BuildContext context) {
    final allProductsController = Get.put(CAllProductsController());
    allProductsController.assignProducts(allProducts);

    return Column(
      children: [
        // -- dropdown box --
        DropdownButtonFormField(
          hint: const Text(
            'sort by:',
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Iconsax.sort,
            ),
          ),
          items: [
            'sort by:',
            'name',
            'highest price',
            'lowest price',
            'sale',
            'newest',
            'popularity'
          ]
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  enabled: true,
                  child: Text(
                    option,
                  ),
                ),
              )
              .toList(),
          value: allProductsController.selectedSortOption.value,
          onChanged: (value) {
            allProductsController.sortProductsBy(value!);
          },
        ),

        const SizedBox(
          height: CSizes.spaceBtnSections,
        ),

        // -- products --
        Obx(
          () => CGridLayout(
            itemCount: allProductsController.products.length,
            itemBuilder: (_, index) {
              return CProductCardVertical(
                product: allProductsController.products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
