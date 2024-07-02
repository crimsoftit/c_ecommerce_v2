import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/features/personalization/controllers/addresses_controller.dart';
import 'package:duara_ecommerce/features/personalization/screens/addresses/add_new_address.dart';
import 'package:duara_ecommerce/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressesScreen extends StatelessWidget {
  const UserAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final addressesController = Get.put(CAddressesController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CAddNewAddressesScreen());
        },
        backgroundColor: CColors.rBrown,
        child: const Icon(
          Iconsax.add,
          color: CColors.white,
        ),
      ),
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'me addresses',
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                fontSizeFactor: 0.8,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Obx(
            () {
              return FutureBuilder(
                // use key to trigger refresh
                key: Key(addressesController.refreshData.value.toString()),

                future: addressesController.fetchAllUserAddresses(),
                builder: (context, snapshot) {
                  // -- helper function to handle loader, no record, and(or) error message --
                  final response =
                      CCloudHelperFunctions.checkMultipleRecordsState(
                          snapshot: snapshot);

                  if (response != null) return response;

                  // -- record found --
                  final addresses = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return CSingleAddress(
                        address: addresses[index],
                        onTap: () {
                          addressesController.selectAddress(addresses[index]);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
