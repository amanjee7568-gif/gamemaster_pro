import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  void loadUserData() {
    emit(const HomeLoading());

    try {
      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        // Simulate successful data loading
        emit(const HomeLoaded(
          username: 'Player1',
          gamesPlayed: 12,
          achievements: 8,
        ));
      });
    } catch (e) {
      emit(const HomeError(message: 'Failed to load user data'));
    }
  }

  void updateStats(int gamesPlayed, int achievements) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(
        gamesPlayed: gamesPlayed,
        achievements: achievements,
      ));
    }
  }
}
