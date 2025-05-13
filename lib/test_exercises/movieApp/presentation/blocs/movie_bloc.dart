import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/usecases/get_movies.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_event.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUsecase _getMovies;

  MovieBloc({
    required GetMoviesUsecase getMovies,
  })  : _getMovies = getMovies,
        super(MoviesLoadingState()) {
    on<GetMoviesEvent>(_onGetMovies);
  }

  Future<void> _onGetMovies(
      GetMoviesEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MoviesLoadingState());
      final movies = await _getMovies.getMovies(event.token);
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesFailureState(e.toString()));
    }
  }
}
