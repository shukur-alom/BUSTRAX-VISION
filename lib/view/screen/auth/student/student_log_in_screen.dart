import 'package:diu_bus_tracking/view/screen/auth/student/complete_profile_screen.dart';
import 'package:diu_bus_tracking/view/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentLogInScreen extends StatefulWidget {
  const StudentLogInScreen({super.key});

  @override
  State<StudentLogInScreen> createState() => _StudentLogInScreenState();
}

class _StudentLogInScreenState extends State<StudentLogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                "Lets Sign you in",
                style: GoogleFonts.outfit(
                    fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome back ,\n'
                'You have been missed',
                style: GoogleFonts.outfit(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "DIU email"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.offAll(() => const MapScreen());
                            },
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.outfit(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do not have an account?",
                            style: GoogleFonts.outfit(
                                fontSize: 18, color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const CompleteProfileScreen());
                            },
                            child: Text(
                              "Register Now",
                              style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
