abstract class MovieEvent {}

class GetMoviesEvent extends MovieEvent {
  final String token;

  GetMoviesEvent(this.token);
}
