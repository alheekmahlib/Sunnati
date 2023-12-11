import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/lists.dart';
import '../screens/books/data/models/collection_model.dart';
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
  int currentBookNumber = 1;

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
  set currentBookChapters(hadiths) {}
  List<List<HadithArabicModel>> get currentBookChapters {
    final Map<String, List<HadithArabicModel>> groupedMap = {};
    for (var hadith in _tempArabicHadiths) {
      if (groupedMap.containsKey(hadith.babNumber)) {
        groupedMap[hadith.babNumber]!.add(hadith);
      } else {
        groupedMap[hadith.babNumber] = [hadith];
      }
    }
    log('message');
    final List<List<HadithArabicModel>> hadiths = [];
    hadiths.addAll(groupedMap.values);
    return hadiths;
  }

  // * [All Books]
  String get currentBookDir =>
      'assets/json/books_data/${_allCollections[currentCollectionIndex].name}_books';
  // Future<List<String>> getCurrentCollectionBooks() async{
  //   try {
  //     final String data =
  //         await rootBundle.loadString('assets/json/collections.json');
  //     final List jsonData = json.decode(data);
  //     _allCollections
  //         .assignAll((jsonData).map((item) => Collection.fromJson(item)));
  //     log("Collections Length: ${_allCollections.length}");
  //   } catch (e) {
  //     log('Error loading data: $e');
  //   }
  // };

  String get currentBookName => currentCollection.booksNames.firstWhere(
      (e) => int.parse(e['book_number']) == currentBookNumber)["book_name"];
  // * [Book Screen]
  Collection get currentCollection => _allCollections[currentCollectionIndex];

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

extension Getters on BooksController {
  List<Collection> getCollectionsGroupByTitle(title) {
    if (title == Constants.collectionsGroupsTitles[0]) {
      return theSixBooksCollection;
    } else if (title == Constants.collectionsGroupsTitles[1]) {
      return theNineBooksCollection;
    } else {
      return theOtherBooksCollection;
    }
  }

  List<Collection> get theSixBooksCollection => _allCollections.sublist(0, 6);
  List<Collection> get theNineBooksCollection => _allCollections.sublist(6, 10);
  List<Collection> get theOtherBooksCollection => _allCollections.sublist(10);
}

extension Utils on BooksController {
  void copyHadithText() {}
  void shareHadith() {}
  Future<void> loadBooksData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/json/collections.json');
      final List jsonData = json.decode(data);
      _allCollections
          .assignAll((jsonData).map((item) => Collection.fromJson(item)));
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

  Future<List<HadithArabicModel>> getHadithsForTheCurrentBook() async {
    final String arJsonPath = '$currentBookDir/arabic/$currentBookNumber.json';

    final data =
        json.decode(await rootBundle.loadString(arJsonPath, cache: false));
    final hadiths =
        List.generate(data.length, (i) => HadithArabicModel.fromJson(data[i]));
    _tempArabicHadiths = hadiths;
    return hadiths;
  }

  Future<void> getHadithsForTheCurrentBookFor2ndLang() async {
    tempHadithsForSecondLang.clear();
    final currentLang = getCurrentLangName();
    final String secondJsonPath =
        '$currentBookDir/$currentLang/$currentBookNumber.json';
    try {
      final data = json
          .decode(await rootBundle.loadString(secondJsonPath, cache: false));
      tempHadithsForSecondLang.value = List.generate(data.length, (i) {
        return switch (currentLang) {
          'english' => HadithEnglishModel.fromJson(data[i]),
          _ => HadithBaseModel.fromJson(data[i]),
        };
      });
    } catch (e) {
      log("error");
    }
  }

  Future<void> getAndSetHadiths() async {
    await Future.wait([
      getHadithsForTheCurrentBook(),
      getHadithsForTheCurrentBookFor2ndLang()
    ]);
    currentBookChapters = _tempArabicHadiths;
  }
}
