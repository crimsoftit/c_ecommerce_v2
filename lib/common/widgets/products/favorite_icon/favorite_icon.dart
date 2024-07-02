import 'package:duara_ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:duara_ecommerce/features/shop/controllers/product/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CFavoriteIcon extends StatelessWidget {
  const CFavoriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(CWishlistController());

    return Obx(
      () {
        return CCircularIcon(
          icon: wishlistController.isInWishlist(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          color: wishlistController.isInWishlist(productId) ? Colors.red : null,
          onPressed: () => wishlistController.toggleWishlistEntry(productId),
        );
      },
    );
  }
}
