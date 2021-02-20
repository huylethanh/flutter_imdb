import 'package:flutter/widgets.dart';
import 'package:flutter_imdb/Models/SearchResult.dart';
import 'package:flutter_imdb/Services/ImdbSevice.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchResult> searches = [];
  bool isLoading = false;
  bool canLoadMore = true;

  void search({String textSearch, int page = 1}) async {
    if (page == 1) {
      searches.clear();
    }

    setLoading(true);
    if (page > 1) {
      await Future.delayed(Duration(seconds: 2));
    }

    var result = await ImdbService().searchByName(textSearch, page);
    if (result.length == 0) {
      setCanLoad(true);
      setLoading(false);
      return;
    }

    searches.addAll(result);
    notifyListeners();
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setCanLoad(bool value) {
    canLoadMore = value;
    notifyListeners();
  }
}
