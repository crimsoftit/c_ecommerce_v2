import 'package:duara_ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:duara_ecommerce/features/personalization/screens/settings/settings.dart';
import 'package:duara_ecommerce/features/shop/screens/home/home.dart';
import 'package:duara_ecommerce/features/shop/screens/store/store.dart';
import 'package:duara_ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavMenuController());
    final isDark = CHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80.0,
          elevation: 0,
          selectedIndex: navController.selectedIndex.value,
          onDestinationSelected: (index) {
            navController.selectedIndex.value = index;
          },
          backgroundColor:
              isDark ? CColors.rBrown : CColors.rBrown.withOpacity(0.1),
          indicatorColor: isDark
              ? CColors.white.withOpacity(0.3)
              : CColors.rBrown.withOpacity(0.3),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: 'store',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'wishlist',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting),
              label: 'account',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'profile',
            ),
            // NavigationDestination(
            //   icon: Icon(Iconsax.warning_2),
            //   label: 'error',
            // ),
          ],
        ),
      ),
      body: Obx(() => navController.screens[navController.selectedIndex.value]),
    );
  }
}

class NavMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const CStoreScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
    // const DataErrorScreen(
    //   lottieImage: CImages.errorDataLottie,
    //   txt: 'error',
    // ),
  ];
}
