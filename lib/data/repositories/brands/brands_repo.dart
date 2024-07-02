import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/features/shop/models/brands_model.dart';
import 'package:duara_ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:duara_ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:duara_ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CBrandsRepo extends GetxController {
  static CBrandsRepo get instance => Get.find();

  /// -- variables --
  final _db = FirebaseFirestore.instance;

  /// -- fetch all categories --
  Future<List<CBrandModel>> fetchAllBrands() async {
    try {
      final snapshot = await _db.collection('brands').get();

      final result =
          snapshot.docs.map((e) => CBrandModel.fromSnapshot(e)).toList();

      return result;
    } on FirebaseException catch (e) {
      throw CFirebaseExceptions(e.code).message;
    } on FormatException catch (e) {
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'something went wrong while fetching all brands!';
    }
  }

  /// -- fetch brands for specific category --
  Future<List<CBrandModel>> fetchCategorySpecificBrands(String catId) async {
    try {
      // query to fetch all docs where categoryId matches catId
      QuerySnapshot bCategoryQuery = await _db
          .collection('brandsCategory')
          .where('categoryId', isEqualTo: catId)
          .get();

      // extract brandIds from the docs
      List<String> brandIds =
          bCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      // query to fetch all docs where categoryId matches catId
      final brandsQuery = await _db
          .collection('brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      // extract brand names and(or) other relevant data from the docs
      List<CBrandModel> brands =
          brandsQuery.docs.map((doc) => CBrandModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw CFirebaseExceptions(e.code).message;
    } on FormatException catch (e) {
      throw CFormatExceptions(e.message);
    } on PlatformException catch (e) {
      throw CPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'something went wrong while fetching category-specific brands!';
    }
  }
}
