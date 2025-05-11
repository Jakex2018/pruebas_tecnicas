import 'package:prueba_tecnica_01/test_exercises/movieApp/data/datasources/movie_api_services.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiServices api;

  MovieRepositoryImpl(this.api);

  @override
  Future<List<Movie>> getMovies(String token) async {
    final models = await api.getMovies(token);
    return models
        .map((model) => Movie(
              title: model.title,
              description: model.description,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }
}
