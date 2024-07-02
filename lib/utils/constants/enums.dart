/* -- list of enums -- */
// cannot be created inside a class

enum CProductType {
  single,
  variable,
}

enum CTextSizes {
  small,
  medium,
  large,
}

enum OrderStatus {
  processing,
  shipped,
  delivered,
}

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
}

enum InventoryStatus {
  savedToDatabase,
  credited,
  sold,
  delivered,
}
