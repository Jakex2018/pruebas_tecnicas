class Movie {
  final String title;
  final String description;
  final String imageUrl;

  Movie({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['original_title'] ?? 'Sin título',
      description: json['overview'] ?? '',
      imageUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '',
    );
  }
}
