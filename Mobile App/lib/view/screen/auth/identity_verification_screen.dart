import 'package:diu_bus_tracking/controller/mqtt_controller.dart';
import 'package:diu_bus_tracking/controller/person_identification_controller.dart';
import 'package:diu_bus_tracking/view/screen/auth/admin/admin_log_in_screen.dart';
import 'package:diu_bus_tracking/view/screen/auth/student/complete_profile_screen.dart';
import 'package:diu_bus_tracking/view/utility/app_theme_data.dart';
import 'package:diu_bus_tracking/view/utility/assets_path.dart';
import 'package:diu_bus_tracking/view/widgets/auth/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  @override
  void initState() {
    Get.find<MqttController>().connectToMqtt();
    super.initState();
  }

  final identificationController = Get.find<PersonIdentificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                AssetsPath.identifyPerson,
                height: 300,
                width: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Identify Yourself",
                style: GoogleFonts.roboto(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "This verification process confirms your "
                    "identity and determines\n your role."
                    "It authenticates whether you are a general user or\n an administrator."
                    " Please proceed to complete the identity\n check to access relevant features.",
                    style: GoogleFonts.ubuntu(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    label: "Student",
                    backgroundColor: Colors.deepPurple,
                    onPressed: () {
                      Get.changeTheme(AppThemeData.studentThemeData);
                      identificationController.changeItToStudent();
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const CompleteProfileScreen(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  CustomElevatedButton(
                    label: "Admin",
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Get.changeTheme(AppThemeData.adminThemeData);
                      identificationController.changeItToAdmin();
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const AdminLogInScreen(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
