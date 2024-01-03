import 'dart:convert';

import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/books/data/models/ar_hadith_model.dart';
import '../screens/home/data/models/time_now.dart';
import '../screens/search/data/models/search_model.dart';
import 'books_controller.dart';

class SearchControllers extends GetxController {
  var searchHistory = <SearchItem>[].obs;
  final RxList<ARHadithModel> searchResults = <ARHadithModel>[].obs;
  List<int> selectedCollections = [];
  late GroupButtonController checkboxesController;

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  void selectCollectionById(int collectionId) =>
      selectedCollections.add(collectionId);

  void unslectCollectionById(int collectionId) =>
      selectedCollections.remove(collectionId);

  Future<void> loadSearchHistory() async {
    List<Map<String, dynamic>> rawHistory = sl<SharedPreferences>()
            .getStringList(SEARCH_HISTORY)
            ?.map((item) => jsonDecode(item) as Map<String, dynamic>)
            .toList() ??
        [];
    searchHistory.value =
        rawHistory.map((item) => SearchItem.fromMap(item)).toList();
  }

  Future<void> addSearchItem(String query) async {
    TimeNow timeNow = TimeNow();
    final prefs = sl<SharedPreferences>();
    _getResult(query);

    SearchItem newItem = SearchItem(query, timeNow.lastTime);
    searchHistory.removeWhere(
        (item) => item.query == query); // Remove duplicate if exists
    searchHistory.insert(0, newItem); // Add to the top
    await prefs.setStringList(SEARCH_HISTORY,
        searchHistory.map((item) => jsonEncode(item.toMap())).toList());
  }

  Future<void> removeSearchItem(SearchItem item) async {
    final prefs = sl<SharedPreferences>();

    searchHistory.remove(item);
    await prefs.setStringList(SEARCH_HISTORY,
        searchHistory.map((item) => jsonEncode(item.toMap())).toList());
  }

  Future<void> _getResult(String searchQuery) async {
    final foundedHadiths = await sl<BooksController>()
        .searchForHadithsByStringQuery(searchQuery, selectedCollections);
    if (foundedHadiths.isNotEmpty) {
      searchResults.addAll(foundedHadiths);
    }
  }
}
