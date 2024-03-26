import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/presentation/screens/authentication/login.dart';
import '/core/constants/app_assets.dart';
import '/core/constants/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(paddingDefault),
          child: Column(
            children: [
              Expanded(
                child: Lottie.asset(AppAssets.onboarding),
              ),
              const Text(
                'Welcome to Expensio',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              const SizedBox(height: 10),
              const Text(
                'Manage all your Expenses with ease',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              const SizedBox(height: 100),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.maxFinite),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Login()));
                  },
                  child: const Text("Get Started"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
