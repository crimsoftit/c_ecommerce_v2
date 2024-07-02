import 'package:duara_ecommerce/app.dart';
import 'package:duara_ecommerce/data/repositories/auth/auth_repo.dart';
import 'package:duara_ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;

// ---- entry point of our flutter application ----
Future<void> main() async {
  // -- todo: add widgets binding --
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  // -- todo: init local storage (GetX Local Storage) --
  await GetStorage.init();

  // todo: await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // todo: initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthRepo()));

  // todo: initialize authentication
  runApp(const App());
}
