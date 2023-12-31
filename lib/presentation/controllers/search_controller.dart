import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../screens/home/data/models/time_now.dart';
import '../screens/search/data/models/search_model.dart';

class SearchControllers extends GetxController {
  var searchHistory = <SearchItem>[].obs;
  List<int> booksSelected = [];
  late GroupButtonController checkboxesController;
  TextEditingController textSerachController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

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
    final prefs = await SharedPreferences.getInstance();

    SearchItem newItem = SearchItem(query, timeNow.lastTime);
    searchHistory.removeWhere(
        (item) => item.query == query); // Remove duplicate if exists
    searchHistory.insert(0, newItem); // Add to the top
    await prefs.setStringList(SEARCH_HISTORY,
        searchHistory.map((item) => jsonEncode(item.toMap())).toList());
  }

  Future<void> removeSearchItem(SearchItem item) async {
    final prefs = await SharedPreferences.getInstance();

    searchHistory.remove(item);
    await prefs.setStringList(SEARCH_HISTORY,
        searchHistory.map((item) => jsonEncode(item.toMap())).toList());
  }
}
