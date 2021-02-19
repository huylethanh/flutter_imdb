import 'package:flutter/widgets.dart';
import 'package:flutter_imdb/Models/SearchResult.dart';
import 'package:flutter_imdb/Services/ImdbSevice.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchResult> searches;

  void search(String textSearch) async {
    searches = await ImdbService().searchByName(textSearch);
    notifyListeners();
  }
}
