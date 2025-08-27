import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/games/games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit() : super(GamesInitial()) {
    _loadGames();
  }

  void _loadGames() {
    emit(GamesLoading());

    // Sample games data - in a real app this would come from an API or database
    final games = [
      Game(
        id: 'chess',
        title: 'Chess',
        description: 'Classic strategy board game',
        category: 'Board Games',
        imageUrl: 'assets/images/chess.png',
      ),
      Game(
        id: 'carrom',
        title: 'Carrom',
        description: 'Traditional Indian board game',
        category: 'Board Games',
        imageUrl: 'assets/images/carrom.png',
      ),
      Game(
        id: 'snake_ladder',
        title: 'Snake & Ladder',
        description: 'Classic board game of ups and downs',
        category: 'Board Games',
        imageUrl: 'assets/images/snake_ladder.png',
      ),
      Game(
        id: 'rummy',
        title: 'Rummy',
        description: 'Popular card matching game',
        category: 'Card Games',
        imageUrl: 'assets/images/rummy.png',
      ),
      Game(
        id: 'poker',
        title: 'Poker',
        description: 'Classic casino card game',
        category: 'Card Games',
        imageUrl: 'assets/images/poker.png',
      ),
      Game(
        id: 'teen_patti',
        title: 'Teen Patti',
        description: 'Indian version of poker',
        category: 'Card Games',
        imageUrl: 'assets/images/teen_patti.png',
      ),
      Game(
        id: '2048',
        title: '2048',
        description: 'Addictive number puzzle game',
        category: 'Puzzle Games',
        imageUrl: 'assets/images/2048.png',
      ),
      Game(
        id: 'sudoku',
        title: 'Sudoku',
        description: 'Number placement puzzle',
        category: 'Puzzle Games',
        imageUrl: 'assets/images/sudoku.png',
      ),
      // More games would be added here to reach 40+
    ];

    emit(GamesLoaded(games: games));
  }

  void selectGame(Game game) {
    if (state is GamesLoaded) {
      emit((state as GamesLoaded).copyWith(selectedGame: game));
    }
  }

  void clearSelection() {
    if (state is GamesLoaded) {
      emit((state as GamesLoaded).copyWith(selectedGame: null));
    }
  }
}
