// ============================================================================
// ⚠️ WARNING: THIS IS JUST A TEMPLATE HOME VIEW - PLEASE REPLACE ENTIRELY
// This file shows basic Bloc UI patterns and should be completely rewritten
// based on your specific home screen UI requirements.
// DO NOT KEEP ANY OF THIS TEMPLATE CODE IN YOUR FINAL APP!
// The "Chef's Kitchen" theme is just for demonstration purposes!
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home/home_cubit.dart';
import 'package:my_app/features/home/home_state.dart';
import 'package:my_app/shared/app_colors.dart';

// ⚠️ TEMPLATE: Replace with your actual home widget
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ TEMPLATE: This shows basic BlocProvider usage - adapt to your needs
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        // ⚠️ TEMPLATE: Replace with your actual app bar
        appBar: AppBar(
          title: const Text('Chef\'s Kitchen 👨‍🍳'), // ⚠️ TEMPLATE: Change title
          backgroundColor: kcPrimaryColor,
          foregroundColor: Colors.white,
          actions: [
            // ⚠️ TEMPLATE: Replace with your actual actions
            IconButton(
              icon: const Icon(Icons.restaurant),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kitchen orders coming up! 🍽️')), // ⚠️ TEMPLATE: Change message
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // ⚠️ TEMPLATE: Replace with your actual welcome message
                          Text(
                            '🍳 Welcome to the Kitchen! 🍳', // ⚠️ TEMPLATE: Change title
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          // ⚠️ TEMPLATE: Replace with your actual description
                          Text(
                            'Your code is perfectly cooked and ready to serve! Built with love using Flutter Cubit. 👨‍🍳✨', // ⚠️ TEMPLATE: Change description
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ⚠️ TEMPLATE: This shows basic BlocBuilder usage - adapt to your states
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoaded) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                // ⚠️ TEMPLATE: Replace with your actual content
                                Text(
                                  '🥘 Recipe Counter', // ⚠️ TEMPLATE: Change section title
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 12),
                                // ⚠️ TEMPLATE: Replace with your actual state data display
                                Text(
                                  'Dishes Cooked: ${state.counter} 🍽️', // ⚠️ TEMPLATE: Change data display
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kcPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // ⚠️ TEMPLATE: Replace with your actual action buttons
                                    ElevatedButton.icon(
                                      onPressed: () => context.read<HomeCubit>().incrementCounter(), // ⚠️ TEMPLATE: Change action
                                      icon: const Icon(Icons.restaurant_menu), // ⚠️ TEMPLATE: Change icon
                                      label: const Text('Cook!'), // ⚠️ TEMPLATE: Change label
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kcPrimaryColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    // ⚠️ TEMPLATE: Replace with your actual secondary button
                                    OutlinedButton.icon(
                                      onPressed: () => context.read<HomeCubit>().resetCounter(), // ⚠️ TEMPLATE: Change action
                                      icon: const Icon(Icons.cleaning_services), // ⚠️ TEMPLATE: Change icon
                                      label: const Text('Clean Kitchen'), // ⚠️ TEMPLATE: Change label
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      // ⚠️ TEMPLATE: Replace with your actual loading state
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ⚠️ TEMPLATE: Replace with your actual section title
                          Text(
                            '🍴 Chef\'s Menu', // ⚠️ TEMPLATE: Change section title
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          // ⚠️ TEMPLATE: Replace with your actual dialog/action button
                          ElevatedButton.icon(
                            onPressed: () {
                              // ⚠️ TEMPLATE: Replace with your actual dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('🍳 Kitchen Status'), // ⚠️ TEMPLATE: Change dialog title
                                  content: const Text('Your code has been perfectly seasoned and is ready to serve! This kitchen runs on Flutter Cubit with a dash of Equatable. Bon appétit! 👨‍🍳✨'), // ⚠️ TEMPLATE: Change dialog content
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Delicious! 😋'), // ⚠️ TEMPLATE: Change button text
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.info_outline), // ⚠️ TEMPLATE: Change icon
                            label: const Text('Kitchen Status'), // ⚠️ TEMPLATE: Change label
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kcSecondaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// ⚠️ REMINDER: Replace this entire file with your actual home screen
// The Chef's Kitchen theme above is just to demonstrate basic Bloc patterns and should not be used
// in your production app. Replace with your actual:
// - Real UI components
// - Actual business logic
// - Proper state management
// - Your app's specific functionality
// ============================================================================