import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/auth_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/chat_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/services/auth_services.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/data/datasources/movie_api_services.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/data/repository/movie_repository_impl.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/domain/usecases/get_movies.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/blocs/movie_bloc.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/screens/movie_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/provider/todo_list_provider.dart';

class AppProvider {
  static get allProviders => [
        Provider<Dio>(create: (_) => Dio()), // ✅ esto primero

        ChangeNotifierProvider(create: (_) => TodoListProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        Provider<AuthServices>(create: (_) => AuthServices()),

        RepositoryProvider(
            create: (context) => MovieApiServices(
                context.read<Dio>())), // ✅ ahora Dio ya está disponible

        RepositoryProvider(
          create: (context) =>
              MovieRepositoryImpl(context.read<MovieApiServices>()),
        ),

        RepositoryProvider(
          create: (context) =>
              GetMoviesUsecase(context.read<MovieRepositoryImpl>()),
        ),

        BlocProvider(
          create: (context) =>
              MovieBloc(getMovies: context.read<GetMoviesUsecase>()),
          child: const MovieScreen(),
        )
      ];
}
