class CPaymentMethodModel {
  CPaymentMethodModel({
    required this.platformName,
    required this.platformLogo,
  });

  String platformName, platformLogo;

  static CPaymentMethodModel empty() {
    return CPaymentMethodModel(
      platformName: '',
      platformLogo: '',
    );
  }
}
