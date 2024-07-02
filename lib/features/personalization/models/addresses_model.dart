import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duara_ecommerce/utils/formatters/formatters.dart';

class CAddressesModel {
  String id;

  final String name, phoneNumber, street, city, state, postalCode, country;

  final DateTime? dateTime;
  bool selectedAddress;

  CAddressesModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formatedPhoneNo => CFormatter.formatPhoneNumber(phoneNumber);

  static CAddressesModel empty() {
    return CAddressesModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

  factory CAddressesModel.fromMap(Map<String, dynamic> data) {
    return CAddressesModel(
      id: data['id'] as String,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      street: data['street'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      postalCode: data['postalCode'] as String,
      country: data['country'] as String,
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      selectedAddress: data['selectedAddress'] as bool,
    );
  }

  /// -- factory constructor to create a CAddressesModel from a DocumentSnapshot object
  factory CAddressesModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return CAddressesModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      selectedAddress: data['selectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
