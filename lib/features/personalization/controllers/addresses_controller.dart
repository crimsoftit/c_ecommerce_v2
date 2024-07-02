import 'package:duara_ecommerce/data/repositories/addresses/addresses_repo.dart';
import 'package:duara_ecommerce/features/personalization/models/addresses_model.dart';
import 'package:duara_ecommerce/utils/constants/image_strings.dart';
import 'package:duara_ecommerce/utils/helpers/network_manager.dart';
import 'package:duara_ecommerce/utils/popups/full_screen_loader.dart';
import 'package:duara_ecommerce/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CAddressesController extends GetxController {
  static CAddressesController get instance => Get.find();

  /// -- variables --
  final Rx<CAddressesModel> selectedAddress = CAddressesModel.empty().obs;

  RxBool refreshData = true.obs;
  final addressesRepo = Get.put(CAddressesRepo());

  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressesFormKey = GlobalKey<FormState>();

  /// -- fetch all user-specific addresses --
  Future<List<CAddressesModel>> fetchAllUserAddresses() async {
    try {
      final userAddresses = await addressesRepo.fetchUserAddresses();
      selectedAddress.value = userAddresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () {
          return CAddressesModel.empty();
        },
      );

      return userAddresses;
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'address(es) not found!',
        message: e.toString(),
      );

      return [];
    }
  }

  Future addNewAddress() async {
    try {
      // start loader
      CFullScreenLoader.openLoadingDialog(
        'adding addresses...',
        CImages.docerAnimation,
      );

      // check internet connectivity
      final isConnected = await CNetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        CPopupSnackBar.customToast(
          message: 'offline...',
        );
        return;
      }

      // check form validation
      if (!addressesFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      // save user address data
      final userAddress = CAddressesModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNo.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final addressId = await addressesRepo.addNewAddress(userAddress);

      // update selected address status
      userAddress.id = addressId;
      await selectAddress(userAddress);

      // remove loader
      CFullScreenLoader.stopLoading();

      // show success message
      CPopupSnackBar.successSnackBar(
        title: 'ngrats!',
        message: 'address added successfully',
      );

      // refresh addresses data
      refreshData.toggle();

      // reset fields
      resetFormFields();

      // redirect to the relevant screen
      Navigator.of(Get.context!).pop();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CPopupSnackBar.errorSnackBar(
        title: 'error saving addresses!',
        message: e.toString(),
      );
    }
  }

  Future selectAddress(CAddressesModel currentlySelectedAddress) async {
    try {
      // -- clear the 'selected' field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressesRepo.updateSelectedAddressField(
            selectedAddress.value.id, false);
      }

      // -- assign selected address
      currentlySelectedAddress.selectedAddress = true;
      selectedAddress.value = currentlySelectedAddress;

      // -- set the 'selected' field to true for the currently selected address
      await addressesRepo.updateSelectedAddressField(
          selectedAddress.value.id, true);
    } catch (e) {
      CPopupSnackBar.errorSnackBar(
        title: 'address selection error!',
        message: e.toString(),
      );
    }
  }

  /// -- function to reset form fields --
  void resetFormFields() {
    name.clear();
    phoneNo.clear();
    street.clear();
    city.clear();
    state.clear();
    country.clear();
    addressesFormKey.currentState?.reset();
  }
}
