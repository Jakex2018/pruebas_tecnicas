import 'package:dio/dio.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';

class MovieApiServices {
  final Dio _dio;
  MovieApiServices(this._dio);

  Future<List<Movie>> getMovies(String token) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/discover/movie',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print("Respuesta de la API: ${response.data}");

      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => Movie.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error al obtener películas: $e");
      rethrow;
    }
  }
}
