import 'package:diu_bus_tracking/controller_binder.dart';
import 'package:diu_bus_tracking/view/screen/auth/splash_screen.dart';
import 'package:diu_bus_tracking/view/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeData.studentThemeData,
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
    );
  }
}
