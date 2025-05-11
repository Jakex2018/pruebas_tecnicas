import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';

class MovieState {}

class MoviesInitialState extends MovieState {}

class MoviesLoadingState extends MovieState {}

class MoviesLoaded extends MovieState {
  final List<Movie> movies;

  MoviesLoaded(this.movies);
}

class MoviesFailureState extends MovieState {
  final String message;

  MoviesFailureState(this.message);
}
