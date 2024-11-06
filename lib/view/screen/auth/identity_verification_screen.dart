import 'package:diu_bus_tracking/view/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
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
                height: 400,
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
                    width: 7,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    "This verification process confirms your "
                    "identity and determines\n your role."
                    "It authenticates whether you are a general user or\n an administrator."
                    " Please proceed to complete the identity check\n to access relevant features.",
                    style: GoogleFonts.ubuntu(fontSize: 14),
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
