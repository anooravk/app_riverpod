
import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  List<Movie>? movies;
  int? page;

  MoviesModel({
    this.movies,
    this.page,
  });

  MoviesModel copyWith({
    List<Movie>? movies,
    int? page,
  }) =>
      MoviesModel(
        movies: movies ?? this.movies,
        page: page ?? this.page,
      );

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    movies: json["movies"] == null ? [] : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "movies": movies == null ? [] : List<dynamic>.from(movies!.map((x) => x.toJson())),
    "page": page,
  };
}

class Movie {
  int? id;
  String? backdropPath;
  List<String>? genres;
  String? originalTitle;
  String? overview;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  ContentType? contentType;

  Movie({
    this.id,
    this.backdropPath,
    this.genres,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.contentType,
  });

  Movie copyWith({
    int? id,
    String? backdropPath,
    List<String>? genres,
    String? originalTitle,
    String? overview,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    ContentType? contentType,
  }) =>
      Movie(
        id: id ?? this.id,
        backdropPath: backdropPath ?? this.backdropPath,
        genres: genres ?? this.genres,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        contentType: contentType ?? this.contentType,
      );

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["_id"],
    backdropPath: json["backdrop_path"],
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    contentType: contentTypeValues.map[json["contentType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "backdrop_path": backdropPath,
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "title": title,
    "contentType": contentTypeValues.reverse[contentType],
  };
}

enum ContentType {
  MOVIE
}

final contentTypeValues = EnumValues({
  "movie": ContentType.MOVIE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
