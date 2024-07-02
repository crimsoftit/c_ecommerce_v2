import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/device/device_utility.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: isDarkTheme
          ? CColors.rBrown.withOpacity(0.1)
          : CColors.rBrown.withOpacity(0.3),
      unselectedLabelColor: CColors.darkGrey,
      labelColor: isDarkTheme ? CColors.white : CColors.grey,
      tabs: tabs,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(CDeviceUtils.getAppBarHeight());
}
