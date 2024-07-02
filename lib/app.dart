import 'package:duara_ecommerce/bindings/general_bindings.dart';
import 'package:duara_ecommerce/routes/app_routes.dart';
import 'package:duara_ecommerce/utils/constants/colors.dart';
import 'package:duara_ecommerce/utils/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  // --- This widget is the root of your application.
  // --- use this class to configure themes, initial bindings, animations, etc. ----
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      initialBinding: CGeneralBindings(),
      getPages: CAppRoutes.pages,

      // -- show loader or circular progress indicator as AuthRepo decides on the relevant screen to load --

      //home: const OnboardingScreen(),
      home: const Scaffold(
        backgroundColor: CColors.rBrown,
        body: Center(
          child: CircularProgressIndicator(
            color: CColors.white,
          ),
        ),
      ),
    );
  }
}
