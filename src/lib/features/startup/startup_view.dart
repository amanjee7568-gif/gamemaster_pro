// ============================================================================
// ⚠️ WARNING: THIS IS JUST A TEMPLATE STARTUP VIEW - PLEASE REPLACE ENTIRELY
// This file shows basic splash screen pattern and should be completely rewritten
// based on your specific startup/splash screen requirements.
// DO NOT KEEP ANY OF THIS TEMPLATE CODE IN YOUR FINAL APP!
// The "Chef's Kitchen" theme is just for demonstration purposes!
// ============================================================================

import 'package:flutter/material.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/shared/app_colors.dart';

// ⚠️ TEMPLATE: Replace with your actual startup widget
class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // ⚠️ TEMPLATE: Replace with your startup logic
  }

  // ⚠️ TEMPLATE: Replace with your actual navigation logic
  void _navigateToHome() async {
    // ⚠️ TEMPLATE: Replace with your actual startup tasks:
    // - Initialize services
    // - Load configuration
    // - Check authentication
    // - etc.
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ TEMPLATE: Replace with your actual startup screen design
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kcPrimaryGradient), // ⚠️ TEMPLATE: Change gradient
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ⚠️ TEMPLATE: Replace with your actual app logo/icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.restaurant_menu, // ⚠️ TEMPLATE: Change to your app icon
                  size: 60,
                  color: kcPrimaryColor,
                ),
              ),
              const SizedBox(height: 32),
              // ⚠️ TEMPLATE: Replace with your actual app name
              const Text(
                'Chef\'s Kitchen', // ⚠️ TEMPLATE: Change to your app name
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 12),
              // ⚠️ TEMPLATE: Replace with your actual tagline
              Text(
                'Please wait, your app is still cooking, if you still encounter this then please made another requests to the chat :D', // ⚠️ TEMPLATE: Change tagline
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              // ⚠️ TEMPLATE: Replace with your actual loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 24),
              // ⚠️ TEMPLATE: Replace with your actual loading message
              Text(
                'Please wait... your code is still cooking! 🔥', // ⚠️ TEMPLATE: Change loading message
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// ⚠️ REMINDER: Replace this entire file with your actual startup screen
// The Chef's Kitchen theme above is just to demonstrate basic startup patterns and should not be used
// in your production app. Replace with your actual:
// - Real app branding
// - Actual startup logic
// - Proper initialization tasks
// - Your app's specific splash screen design
// ============================================================================