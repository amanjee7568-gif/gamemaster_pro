import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home/home_cubit.dart';
import 'package:my_app/features/home/home_state.dart';
import 'package:my_app/shared/app_colors.dart';
import 'package:my_app/shared/text_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadUserData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gaming Platform'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWelcomeCard(context),
                  const SizedBox(height: 16),
                  _buildStatsSection(context),
                  const SizedBox(height: 16),
                  _buildGameLibrarySection(context),
                  const SizedBox(height: 16),
                  _buildLeaderboardSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Welcome Back!',
              style: heading2Style(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return Text(
                    'Hello, ${state.username}! Ready to play some games?',
                    style: bodyStyle(context),
                    textAlign: TextAlign.center,
                  );
                } else if (state is HomeLoading) {
                  return const Text('Loading...');
                } else if (state is HomeError) {
                  return Text('Error: ${state.message}');
                }
                return const Text('Welcome to Gaming Platform!');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Stats',
              style: heading3Style(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Games\nPlayed', '${state.gamesPlayed}'),
                      _buildStatItem(
                          'Achieve-\nments', '${state.achievements}'),
                      _buildStatItem('Level', '5'),
                    ],
                  );
                } else if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  return Text('Error: ${state.message}');
                }
                return const Text('No stats available');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kcPrimaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: kcSecondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGameLibrarySection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Game Library',
              style: heading3Style(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to game library
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('View All Games'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Leaderboard',
              style: heading3Style(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('Coming Soon!'),
          ],
        ),
      ),
    );
  }
}
