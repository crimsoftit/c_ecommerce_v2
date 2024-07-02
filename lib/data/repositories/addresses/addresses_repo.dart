import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/data/repositories/auth/auth_repo.dart';
import 'package:duara_ecommerce/features/personalization/models/addresses_model.dart';
import 'package:get/get.dart';

class CAddressesRepo extends GetxController {
  static CAddressesRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CAddressesModel>> fetchUserAddresses() async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;

      if (userId.isEmpty) {
        throw 'unable to find your info! please try again in a few minutes';
      } else {
        final result = await _db
            .collection('users')
            .doc(userId)
            .collection('addresses')
            .get();

        return result.docs
            .map((documentSnapshot) =>
                CAddressesModel.fromDocumentSnapshot(documentSnapshot))
            .toList();
      }
    } catch (e) {
      throw 'something went wrong while fetching your addresses! please try again later.';
    }
  }

  /// -- clear the "selected" address field for all addresses
  Future<void> updateSelectedAddressField(
      String addressId, bool selected) async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;

      await _db
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw 'unable to update your address selection! please try again later';
    }
  }

  /// -- save new user address --
  Future<String> addNewAddress(CAddressesModel address) async {
    try {
      final userId = AuthRepo.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'an error occurred while saving new address!';
    }
  }
}
