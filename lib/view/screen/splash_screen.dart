import 'package:diu_bus_tracking/view/utility/assetspath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
              ),
              Text(
                "DIU Bus Tracker",
                style: GoogleFonts.acme(
                    color: Colors.black45,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Lottie.asset(
                AssetsPath.splashAnimation,
                controller: _animationController,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _animationController
                    ..duration = const Duration(seconds: 2)
                    ..repeat();
                },
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                "Verify Your Identity",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Student",
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Admin",
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
