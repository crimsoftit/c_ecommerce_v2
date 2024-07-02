import 'package:duara_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:duara_ecommerce/features/personalization/controllers/addresses_controller.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/constants/sizes.dart';
import 'package:duara_ecommerce/utils/helpers/helper_functions.dart';
import 'package:duara_ecommerce/utils/validators/validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CAddNewAddressesScreen extends StatelessWidget {
  const CAddNewAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = CHelperFunctions.isDarkMode(context);

    final addressesController = CAddressesController.instance;
    FocusNode focusNode = FocusNode();

    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        backIconColor: isDarkTheme ? CColors.white : CColors.rBrown,
        title: Text(
          'add new address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: addressesController.addressesFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: addressesController.name,
                  validator: (value) =>
                      CValidator.validateEmptyText('name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: CColors.rBrown,
                    ),
                    labelText: 'name',
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnInputFields,
                ),

                // -- phone number field --
                IntlPhoneField(
                  controller: addressesController.phoneNo,
                  initialCountryCode: 'KE',
                  focusNode: focusNode,
                  dropdownTextStyle: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    height: 0.8,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    label: Text('Phone number'),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: CColors.rBrown,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    height: 0.8,
                  ),
                  keyboardType: TextInputType.phone,
                  languageCode: "en",
                  onChanged: (phone) {
                    //print(controller.cell_no.value);
                  },
                  onCountryChanged: (country) {
                    if (kDebugMode) {
                      print('country changed to: ${country.dialCode}');
                    }
                  },
                  validator: (phone) =>
                      CValidator.validatePhoneNumber(phone.toString()),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addressesController.street,
                        validator: (value) {
                          return CValidator.validateEmptyText('street', value);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.building_31,
                            color: CColors.rBrown,
                          ),
                          labelText: 'street',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: CSizes.spaceBtnInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: addressesController.postalCode,
                        validator: (value) {
                          return CValidator.validateEmptyText(
                            'postal code',
                            value,
                          );
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.code,
                            color: CColors.rBrown,
                          ),
                          labelText: 'postal code',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: CSizes.spaceBtnInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addressesController.city,
                        validator: (value) =>
                            CValidator.validateEmptyText('city', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.building,
                            color: CColors.rBrown,
                          ),
                          labelText: 'city',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: CSizes.spaceBtnInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: addressesController.state,
                        validator: (value) {
                          return CValidator.validateEmptyText('state', value);
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.activity,
                            color: CColors.rBrown,
                          ),
                          labelText: 'state',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: CSizes.spaceBtnInputFields,
                ),
                TextFormField(
                  controller: addressesController.country,
                  validator: (value) {
                    return CValidator.validateEmptyText('country', value);
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.global,
                      color: CColors.rBrown,
                    ),
                    labelText: 'country',
                  ),
                ),
                const SizedBox(
                  height: CSizes.defaultSpace,
                ),
                // - checkout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      addressesController.addNewAddress();
                    },
                    child: Text(
                      'save'.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: CColors.white,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: CSizes.spaceBtnSections,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
