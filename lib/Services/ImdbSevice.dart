import 'dart:convert';

import 'package:flutter_imdb/Models/MovieDetail.dart';
import 'package:flutter_imdb/Models/SearchResult.dart';
import 'package:http/http.dart' as http;

class ImdbService {
  String _baseUrl = 'http://www.omdbapi.com/?apikey=633f1b90';
  Map<String, SearchResult> _searchResults = Map<String, SearchResult>();

  Future<List<SearchResult>> searchByName(String textSearch, int page) async {
    if (page > 10) {
      return [];
    }
    var url = '$_baseUrl&page=$page&s=$textSearch';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      if (map['Response'] == "True") {
        Iterable list = map['Search'];

        var temp = list.map((item) => SearchResult.formJson(item)).toList();

        for (var i = 0; i < temp.length; i++) {
          if (!_searchResults.containsKey(temp[i].imdbID)) {
            _searchResults[temp[i].imdbID] = temp[i];
          }
        }
      }
    }
    return _searchResults.values.toList();
  }

  Future<MovieDetails> getDetail(String id) async {
    var url = '$_baseUrl&plot=full&i=$id';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      if (map['Response'] != "True") {
        return null;
      }

      var detail = MovieDetails.fromJson(map);
      return detail;
    }

    return null;
  }
}
