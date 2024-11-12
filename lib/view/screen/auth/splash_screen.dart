import 'package:diu_bus_tracking/controller/map_controller.dart';
import 'package:diu_bus_tracking/view/screen/map_screen.dart';
import 'package:diu_bus_tracking/view/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this);
    moveToNextScreen(context);
  }

  void moveToNextScreen(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Get.find<MapController>().getCurrentLocation();
    // if (isLoggedIn) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
          child: const MapScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500)),
      (Route<dynamic> route) => false,
    );
    // } else {
    //   Get.offAll(const VerifyEmailScreen());
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
              ),
              Text(
                "DIU Bus\n Tracker",
                style: GoogleFonts.acme(
                    color: Colors.deepPurple,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Lottie.asset(
                height: 400,
                width: 400,
                AssetsPath.splashAnimation,
                controller: _animationController,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _animationController
                    ..duration = const Duration(seconds: 3)
                    ..repeat();
                },
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
