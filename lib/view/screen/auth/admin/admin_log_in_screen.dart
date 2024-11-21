import 'package:diu_bus_tracking/view/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
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
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                  height: 30,
                ),
                TextFormField(
                  controller: _emailTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter an Email address';
                    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@diu\.edu\.bd$')
                        .hasMatch(value!)) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: "DIU email"),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
