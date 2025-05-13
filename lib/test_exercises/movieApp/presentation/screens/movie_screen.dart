import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/models/movie.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_bloc.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_event.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_state.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
    const token =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYmQ2MWUwYzliNzY4MTA3Y2JhZTMxNzE5YjRiMDVlNCIsIm5iZiI6MTY1OTk4NjI2MC45MTEsInN1YiI6IjYyZjE2MTU0ODgwYzkyMDA3ZjE3OTc0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RIjGt_lC5KLVsRNVRv2arnh6FwirSa45VgjNmCUhvTw'; // Reemplaza con el real
    context.read<MovieBloc>().add(GetMoviesEvent(token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba Técnica 03'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Text('');
          } else if (state is MoviesLoaded) {
            return _buildMovieList(state);
          } else if (state is MoviesFailureState) {
            return Text('ERROR ${state.message}');
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMovieList(MoviesLoaded state) {
    final movies = state.movies;
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 30),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Movie movie) {
    const cardWidth = 200.0;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * .4,
              width: cardWidth,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            movie.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
