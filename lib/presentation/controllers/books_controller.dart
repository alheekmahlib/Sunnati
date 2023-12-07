import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../screens/books/data/models/book_model.dart';
import 'general_controller.dart';

class BooksController extends GetxController {
  // final prefs = sl<SharedPreferences>();
  final generalCtrl = sl<GeneralController>();

  final List<Book> _allBooks = [];
  // List<String> authors = [
  //   "bukhari",
  //   "muslim",
  //   "nasai",
  //   "abudawud",
  //   "tirmidhi",
  //   "ibnmajah",
  //   "malik",
  //   "ahmad",
  //   "darimi",
  //   "forty",
  //   "nawawi40",
  //   "riyadussalihin",
  //   "mishkat",
  //   "adab",
  //   "shamail",
  //   "bulugh",
  //   "hisn",
  // ];

  int currentBookIndex = 0;

  @override
  void onInit() async {
    await loadBooksData();
    super.onInit();
  }

  Future<void> loadBooksData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/json/collections.json');
      final Map<String, dynamic> jsonData = json.decode(data);
      _allBooks.assignAll((jsonData['data'] as List)
          .map((item) => Book.fromJson(item))
          .toList());
      log("Books Length: ${_allBooks.length}");
    } catch (e) {
      log('Error loading data: $e');
    }
  }

  Color booksColor(int index) =>
      index == 5 ? const Color(0xffE6DAC8) : Colors.transparent;

  // *  [HOME]  *
  // Hadith get lastReadedHadith => ...
  // Hadith get hadithOfTheDay => ...

  // * [All Books]
  List<Book> get allBooks => _allBooks;

  // * [Book Screen]
  Book get currentBook => _allBooks[currentBookIndex];
  // book chapters

/*

Home Screen:
- [ ] get the last readed hadith.
- [ ] get “hadith of the day”.

  Books Screen:
- [ ] get all books.

- book main view:
- [ ] get book details such as title and about the book etc..	
- [ ] get book chapters.

- book view:
- [ ] get “babs” of the chapter.
- [ ] get “babs” translation.
- [ ] make read more locked with the bab.
- [ ] bookmark the “bab” and show isBookmarked.


Favorites Screen:
- [ ] view favorites with the book name and the chapter.

Serach Tap:
- [ ] make the ability to filter the search between all books or only selected books .. and view it.

*/
}

enum Authors {
  bukhari,
  muslim,
  nasai,
  abudawud,
  tirmidhi,
  ibnmajah,
  malik,
  ahmad,
  darimi,
  forty,
  nawawi40,
  riyadussalihin,
  mishkat,
  adab,
  shamail,
  bulugh,
  hisn,
}

extension MoreDetails on Book {
  String get currentBookAbout =>
      sl<BooksController>()
          .currentBook
          .collection
          .firstWhereOrNull((collection) =>
              collection.lang == sl<GeneralController>().currentLang)
          ?.shortIntro ??
      'NO_ABOUT_ERROR';
}

extension Utils on BooksController {
  void copyHadithText() {}
  void shareHadith() {}
}
