class MovieTrends {
  MovieTrends({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  factory MovieTrends.fromJson(Map<String, dynamic> json) => MovieTrends(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  Result({
    this.overview,
    this.releaseDate,
    this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.voteCount,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.title,
    this.video,
    this.voteAverage,
    this.popularity,
    this.mediaType,
    this.firstAirDate,
    this.originalName,
    this.originCountry,
    this.name,
  });

  String? overview;
  DateTime? releaseDate;
  int? id;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? voteCount;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  String? title;
  bool? video;
  double? voteAverage;
  double? popularity;
  String? mediaType;
  DateTime? firstAirDate;
  String? originalName;
  List<String>? originCountry;
  String? name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    overview: json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    id: json["id"],
    adult: json["adult"] == null ? null : json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    voteCount: json["vote_count"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    posterPath: json["poster_path"],
    title: json["title"] == null ? null : json["title"],
    video: json["video"] == null ? null : json["video"],
    voteAverage: json["vote_average"].toDouble(),
    popularity: json["popularity"].toDouble(),
    mediaType: json["media_type"],
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originalName: json["original_name"] == null ? null : json["original_name"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "overview": overview,
    "release_date": releaseDate == null ? null : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "id": id,
    "adult": adult == null ? null : adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "vote_count": voteCount,
    "original_language": originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "poster_path": posterPath,
    "title": title == null ? null : title,
    "video": video == null ? null : video,
    "vote_average": voteAverage,
    "popularity": popularity,
    "media_type":mediaType,
    "first_air_date": firstAirDate == null ? null : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "original_name": originalName == null ? null : originalName,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry!.map((x) => x)),
    "name": name == null ? null : name,
  };
}