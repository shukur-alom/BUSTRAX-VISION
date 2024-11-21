import 'package:diu_bus_tracking/view/screen/auth/student/complete_profile_screen.dart';
import 'package:diu_bus_tracking/view/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class StudentLogInScreen extends StatefulWidget {
  const StudentLogInScreen({super.key});

  @override
  State<StudentLogInScreen> createState() => _StudentLogInScreenState();
}

class _StudentLogInScreenState extends State<StudentLogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  String? formValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Lets Sign you in",
                  style: GoogleFonts.outfit(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome back ,\n'
                  'You have been missed',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailTEController,
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Please enter an Email address';
                            } else if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@diu\.edu\.bd$')
                                .hasMatch(value!)) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(labelText: "DIU email"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passwordTEController,
                          validator: formValidator,
                          textInputAction: TextInputAction.done,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible =
                                      !_isPasswordVisible; // Toggle state
                                });
                              },
                            ),
                          ),
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
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Get.offAll(() => const MapScreen());
                                }
                              },
                              child: Text(
                                "Sign in",
                                style: GoogleFonts.outfit(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              )),
                        ),
                        const SizedBox(
                          height: 18,
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
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const CompleteProfileScreen(),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                );
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
      ),
    );
  }
}
