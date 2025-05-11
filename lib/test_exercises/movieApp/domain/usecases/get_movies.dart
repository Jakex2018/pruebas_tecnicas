import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/repository/movie_repository.dart';

class GetMoviesUsecase {
  final MovieRepository _repository;

  GetMoviesUsecase(this._repository);

  Future<List<Movie>> getMovies(String token) async {
    return await _repository.getMovies(token);
  }
}
