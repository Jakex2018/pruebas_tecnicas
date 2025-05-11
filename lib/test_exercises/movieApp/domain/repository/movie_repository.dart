import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies(String token);
}
