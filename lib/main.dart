import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:highties_cannabis/model/connectivity/dependemcy_injection.dart';
import 'package:highties_cannabis/screens/registration_and_signup/splash_screen_1.dart';
import 'package:highties_cannabis/state/order_controller.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:get/get.dart';

void main() {
  DependencyInjection.init();
  //Uncomment for Debugging
  runApp(
    DevicePreview(
      //enabled: !kReleaseMode,
      builder: (context) => MyApp(
          // languages: _languages,
          ), // Wrap your app
    ),
  );

  // runApp(const MyApp());
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StateController());
    Get.put(SalesController());
    Get.put(OrderController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff2A6443),
        ),
      ),
      home: const SplashScreenPage1(),
      initialBinding: InitialBindings(),
    );
  }
}
