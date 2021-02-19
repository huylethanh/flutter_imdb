class SearchResult {
  String title;
  String year;
  String imdbID;
  String poster;
  String type;

  SearchResult(this.title, this.year, this.imdbID, this.poster);

  SearchResult.formJson(Map json)
      : title = json['Title'],
        year = json['Year'],
        imdbID = json['imdbID'],
        poster = json['Poster'],
        type = json['Type'];
}
