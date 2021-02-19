class MovieDetails {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String type;
  String totalSeasons;

  MovieDetails(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.totalSeasons);

  MovieDetails.fromJson(Map json)
      : title = json['Title'],
        year = json['Year'],
        rated = json['Rated'],
        released = json['Released'],
        runtime = json['Runtime'],
        genre = json['Genre'],
        director = json['Director'],
        writer = json['Writer'],
        actors = json['Actors'],
        plot = json['Plot'],
        language = json['Language'],
        country = json['Country'],
        awards = json['Awards'],
        poster = json['Poster'],
        imdbRating = json['imdbRating'],
        imdbVotes = json['imdbVotes'],
        imdbID = json['imdbID'],
        type = json['Type'],
        totalSeasons = json['totalSeasons'];
}
