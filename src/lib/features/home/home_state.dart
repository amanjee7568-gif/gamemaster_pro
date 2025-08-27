// ============================================================================
// ⚠️ WARNING: THIS IS JUST A TEMPLATE HOME STATE - PLEASE REPLACE ENTIRELY
// This file shows basic state classes and should be completely rewritten
// based on your specific home screen state requirements.
// DO NOT KEEP ANY OF THIS TEMPLATE CODE IN YOUR FINAL APP!
// ============================================================================

import 'package:equatable/equatable.dart';

// ⚠️ TEMPLATE: Replace with your actual state base class
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// ⚠️ TEMPLATE: Replace with your actual initial state
class HomeInitial extends HomeState {
  const HomeInitial();
}

// ⚠️ TEMPLATE: Replace with your actual loaded state
class HomeLoaded extends HomeState {
  // ⚠️ TEMPLATE: Replace counter with your actual data fields:
  // - User data
  // - API responses
  // - App-specific state
  // - etc.
  final int counter;

  const HomeLoaded({required this.counter});

  @override
  List<Object> get props => [counter];
}

// ============================================================================
// ⚠️ REMINDER: Replace this entire file with your actual home states
// The states above are just to demonstrate basic state management and should not be used
// in your production app. Add proper state classes specific to your app's home screen needs:
// - Loading states
// - Error states  
// - Success states with real data
// - etc.
// ============================================================================