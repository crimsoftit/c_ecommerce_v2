import 'package:cloud_firestore/cloud_firestore.dart';

class CBannerModel {
  String imgUrl;
  final String targetScreen;
  final bool isActive;

  CBannerModel({
    required this.imgUrl,
    required this.targetScreen,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imgUrl,
      'targetScreen': targetScreen,
      'isActive': isActive,
    };
  }

  factory CBannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CBannerModel(
      imgUrl: data["imageUrl"] ?? "",
      targetScreen: data["targetScreen"] ?? "",
      isActive: data["isActive"] ?? false,
    );
  }
}
