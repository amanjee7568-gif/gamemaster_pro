import 'package:equatable/equatable.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

class GamesInitial extends GamesState {}

class GamesLoading extends GamesState {}

class GamesLoaded extends GamesState {
  final List<Game> games;
  final Game? selectedGame;

  const GamesLoaded({
    required this.games,
    this.selectedGame,
  });

  GamesLoaded copyWith({
    List<Game>? games,
    Game? selectedGame,
  }) =>
      GamesLoaded(
        games: games ?? this.games,
        selectedGame: selectedGame ?? this.selectedGame,
      );

  @override
  List<Object?> get props => [games, selectedGame];
}

class GamesError extends GamesState {
  final String message;

  const GamesError(this.message);

  @override
  List<Object> get props => [message];
}

class Game {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;

  Game({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
  });
}
