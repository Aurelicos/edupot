import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/main_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      navBar: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
              ),
              color: Colors.white,
            ),
            const Text("Privacy", style: EduPotDarkTextTheme.headline1),
            const SizedBox(height: 15),
            const Text("Security", style: EduPotDarkTextTheme.smallHeadline),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                gradient: EduPotColorTheme.mainItemGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: MainCard(
                "assets/icons/shield_gradient.svg",
                title: "Enable 2FA",
                description: "Extra account security.",
                gradient: EduPotColorTheme.darkGradient,
                background: false,
                icon: false,
                onSwitch: (bool value) {},
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: EduPotColorTheme.mainItemGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: MainCard(
                "assets/icons/fingerprint.svg",
                title: "Fingerprint",
                description: "Secure app with fingerprint auth.",
                gradient: EduPotColorTheme.darkGradient,
                background: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
