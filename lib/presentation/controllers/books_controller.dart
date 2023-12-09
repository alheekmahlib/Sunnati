import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../screens/books/data/models/book_model.dart';
import '../screens/books/data/models/hadith_model.dart';
import 'general_controller.dart';

class BooksController extends GetxController {
  // final prefs = sl<SharedPreferences>();
  final generalCtrl = sl<GeneralController>();
  bool enableCaching = false;

  final List<Collection> _allCollections = [];

  List<HadithArabicModel> _tempArabicHadiths = [];
  RxList<HadithBaseModel> tempHadithsForSecondLang = <HadithBaseModel>[].obs;

  int currentCollectionIndex = 0;
  int currentBookIndex = 0;

  @override
  void onInit() async {
    await loadBooksData();
    super.onInit();
  }

  Color booksColor(int index) =>
      index == 5 ? const Color(0xffE6DAC8) : Colors.transparent;

  // *  [HOME]  *
  // Hadith get lastReadedHadith => ...
  // Hadith get hadithOfTheDay => ...

  // * [All Collections]
  List<Collection> get allCollections => _allCollections;
  List<List<HadithBaseModel>> get currentBookChapters {
    final Map<String, List<HadithBaseModel>> groupedMap = {};
    for (var hadith in _tempArabicHadiths) {
      if (groupedMap.containsKey(hadith.babNumber)) {
        groupedMap[hadith.babNumber!]!.add(hadith);
      } else {
        groupedMap[hadith.babNumber!] = [hadith];
      }
    }
    return List.generate(groupedMap.length, (i) => groupedMap[i] ?? []);
  }

  // * [All Books]
  String get currentBookDir =>
      'assets/json/books_data/${_allCollections[currentCollectionIndex].name}_books';
  Future<int> getBooksLength() async =>
      await countFilesInDirectory('$currentBookDir/arabic');
  // * [Book Screen]
  Collection get currentCollection => _allCollections[currentBookIndex];

  //* book chapters
  List<HadithArabicModel> get arabicHadiths => _tempArabicHadiths;

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

extension MoreDetails on Collection {
  String get currentBookAbout =>
      sl<BooksController>()
          .currentCollection
          .collection
          .firstWhereOrNull((collection) =>
              collection.lang == sl<GeneralController>().currentLang)
          ?.shortIntro ??
      'NO_ABOUT_ERROR';
}

extension Utils on BooksController {
  void copyHadithText() {}
  void shareHadith() {}
  Future<void> loadBooksData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/json/collections.json');
      final Map<String, dynamic> jsonData = json.decode(data);
      _allCollections.assignAll((jsonData['data'] as List)
          .map((item) => Collection.fromJson(item))
          .toList());
      log("Collections Length: ${_allCollections.length}");
    } catch (e) {
      log('Error loading data: $e');
    }
  }

  String getCurrentLangName() {
    final lang = generalCtrl.currentLang.toLowerCase();
    return switch (lang) {
      'ar' => 'arabic',
      'en' => 'english',
      'bn' => 'bangla',
      'ur' => 'urdu',
      _ => 'arabic'
    };
  }

  Future<void> getHadithsForTheCurrentBook() async {
    final String arJsonPath =
        '$currentBookDir/arabic/${currentBookIndex + 1}.json';

    final data =
        json.decode(await rootBundle.loadString(arJsonPath, cache: false));
    _tempArabicHadiths = List.generate(data.length, (i) => data[i]);
  }

  Future<void> getHadithsForTheCurrentBookFor2ndLang() async {
    tempHadithsForSecondLang.clear();
    final currentLang = getCurrentLangName();
    final String secondJsonPath =
        '$currentBookDir/$currentLang/${currentBookIndex + 1}.json';
    try {
      final data = json
          .decode(await rootBundle.loadString(secondJsonPath, cache: false));
      tempHadithsForSecondLang.value = List.generate(data.length, (i) {
        return switch (currentLang) {
          'english' => HadithBaseModel.fromJson(data[i]),
          _ => HadithBaseModel.fromJson(data[i]),
        };
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<int> countFilesInDirectory(String directoryPath) async {
    try {
      List<String> files = await rootBundle
          .loadStructuredData<List<String>>(directoryPath, (String data) async {
        return data.split('\n').where((e) => e.isNotEmpty).toList();
      });
      int fileCount = files.length;
      return fileCount;
    } catch (e) {
      log('Error reading directory: $e');
      return 10;
    }
  }

  Future<void> getAndSetHadiths() async {
    await Future.wait([
      getHadithsForTheCurrentBook(),
      getHadithsForTheCurrentBookFor2ndLang()
    ]);
  }
}
