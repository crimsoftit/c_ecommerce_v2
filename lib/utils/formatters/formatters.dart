import 'package:intl/intl.dart';

class CFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatUSDCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNo) {
    // assuming a 10-digit US phone no. format: (123) 456-7890
    if (phoneNo.length == 10) {
      return '(${phoneNo.substring(0, 3)}) ${phoneNo.substring(3, 6)} ${phoneNo.substring(6)}';
    } else if (phoneNo.length == 11) {
      return '(${phoneNo.substring(0, 4)}) ${phoneNo.substring(4, 7)} ${phoneNo.substring(7)}';
    }
    return phoneNo;
  }

  /* --- # international format for phone numbers (not fully tested) --- */
  static String intlPhoneNoFormat(String phoneNo) {
    // -- remove any non-digit characters from the phone number
    var digitsOnly = phoneNo.replaceAll(RegExp(r'\D'), '');

    // -- extract the country code from the digitsOnly variable
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // -- add the remaining digits with proper formatting
    final formattedPhoneNo = StringBuffer();
    formattedPhoneNo.write('($countryCode) ');

    int i = 0;

    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1' || countryCode == '+2') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedPhoneNo.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedPhoneNo.write("  ");
      }

      i = end;
    }
    return formattedPhoneNo.toString();
  }
}
