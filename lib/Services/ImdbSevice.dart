import 'dart:convert';

import 'package:flutter_imdb/Models/MovieDetail.dart';
import 'package:flutter_imdb/Models/SearchResult.dart';
import 'package:http/http.dart' as http;

class ImdbService {
  String _baseUrl = 'http://www.omdbapi.com/?apikey=633f1b90';

  Future<List<SearchResult>> searchByName(String textSearch) async {
    var url = '$_baseUrl&s=$textSearch';
    var response = await http.get(url);
    List<SearchResult> result;
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      if (map['Response'] != "True") {
        result = [];
      } else {
        Iterable list = map['Search'];
        result = list.map((item) => SearchResult.formJson(item)).toList();
      }
    } else {
      result = [];
    }

    return result;
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
