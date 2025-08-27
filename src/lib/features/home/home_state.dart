import 'package:equatable/equatable.dart';

// Base state class for home feature
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// Initial state when the app starts
class HomeInitial extends HomeState {
  const HomeInitial();
}

// State when user data is loading
class HomeLoading extends HomeState {
  const HomeLoading();
}

// State when user data is successfully loaded
class HomeLoaded extends HomeState {
  final String username;
  final int gamesPlayed;
  final int achievements;

  const HomeLoaded({
    required this.username,
    required this.gamesPlayed,
    required this.achievements,
  });

  @override
  List<Object> get props => [username, gamesPlayed, achievements];

  HomeLoaded copyWith({
    String? username,
    int? gamesPlayed,
    int? achievements,
  }) {
    return HomeLoaded(
      username: username ?? this.username,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      achievements: achievements ?? this.achievements,
    );
  }
}

// State when there's an error
class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
