import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/assets_data.dart';
import '../../core/utils/constants/lists.dart';
import '../screens/books/data/models/ar_hadith_model.dart';
import '../screens/books/data/models/bn_hadith_model.dart';
import '../screens/books/data/models/collection_model.dart';
import '../screens/books/data/models/en_hadith_model.dart';
import '../screens/books/data/models/ur_hadith_model.dart';
import 'general_controller.dart';

class BooksController extends GetxController {
  // final prefs = sl<SharedPreferences>();
  final generalCtrl = sl<GeneralController>();
  bool enableCaching = false;

  final List<Collection> _allCollections = [];

  final List<ARHadithModel> _tempArabicHadiths = [];
  RxList<ENHadithModel> tempEnglishHadiths = <ENHadithModel>[].obs;

  int currentCollectionIndex = 0;
  int currentBookNumber = 1;

  /// * [Boxes]
  final arabicHadithsBox =
      Hive.lazyBox<ARHadithModel>(AssetsData.arabicHadithsBox);
  final englishHadithsBox =
      Hive.lazyBox<ENHadithModel>(AssetsData.englishHadithsBox);
  final urduHadithsBox = Hive.lazyBox<URHadithModel>(AssetsData.urduHadithsBox);
  final banglaHadithsBox =
      Hive.lazyBox<BNHadithModel>(AssetsData.banglaHadithsBox);

  @override
  void onInit() async {
    await loadBooksData();
    await storeJsonDataToHive();
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
  List<List<ARHadithModel>> get currentBookChapters {
    final Map<String, List<ARHadithModel>> groupedMap = {};
    for (var hadith in _tempArabicHadiths) {
      if (groupedMap.containsKey(hadith.babNumber)) {
        groupedMap[hadith.babNumber]!.add(hadith);
      } else {
        groupedMap[hadith.babNumber] = [hadith];
      }
    }
    log('message');
    final List<List<ARHadithModel>> hadiths = [];
    hadiths.addAll(groupedMap.values);
    return hadiths;
  }

  // * [All Books]
  String get currentBookDir =>
      'assets/json/books_data/${_allCollections[currentCollectionIndex].name}_books';

  String get currentBookName => currentCollection.booksNames.firstWhere(
      (e) => int.parse(e['book_number']) == currentBookNumber)["book_name"];
  // * [Book Screen]
  Collection get currentCollection => _allCollections[currentCollectionIndex];

  //* book chapters
  List<ARHadithModel> get arabicHadiths => _tempArabicHadiths;

  String getHadithTranslationByURN(int arabicURN) {
    return 'TODO'; //TODO:
  }

/*

Home Screen:
- [ ] get the last readed hadith.
- [ ] get “hadith of the day”.

  Books Screen:
- [✅] get all books.
- [ ] sort books

- book main view:
- [✅] get book details such as title and about the book etc..	
- [✅] get book chapters.

- book view:
- [✅] get “babs” of the chapter.
- [✅] get “babs” translation.
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
  riyadussalihin,
  mishkat,
  adab,
  shamail,
  bulugh,
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
      _allCollections.assignAll(
          jsonData.map((item) => Collection.fromJson(item)).toList());
      log("Collections Length: ${_allCollections.length}");
    } catch (e) {
      log('Error loading data: $e');
    }
  }

  void setCurrentCollectionByAuthorName(String authorName) =>
      currentCollectionIndex =
          _allCollections.indexWhere((c) => c.name == authorName);

  String getCurrentLangName() {
    final lang = generalCtrl.currentLang.toLowerCase();
    return lang;
    // return switch (lang) {
    //   'ar' => 'arabic',
    //   'en' => 'english',
    //   'bn' => 'bangla',
    //   'ur' => 'urdu',
    //   _ => 'arabic'
    // };
  }

  Future<void> storeJsonDataToHive() async {
    final collectionsBox = Hive.box<Collection>(AssetsData.collectionsBox);
    final arabicHadithsBox =
        Hive.lazyBox<ARHadithModel>(AssetsData.arabicHadithsBox);
    for (final col in _allCollections) {
      // [1] Collectionsف٥
      collectionsBox.put(col.name, col);
      // [2] Hadiths
      for (final book in col.booksNames) {
        currentBookNumber = int.parse(book['book_number']);
        setCurrentCollectionByAuthorName(col.name);
        final hadiths = await getHadithsForTheCurrentBook();
        for (final h in hadiths) {
          arabicHadithsBox.put(
              '${col.name}_${currentBookNumber}_${h.hadithNumber}', h);
          log('${col.name}_${currentBookNumber}_${h.hadithNumber}');
        }
      }
    }
  }

  Future<List<ARHadithModel>> getHadithsForTheCurrentBook(
      [String? bookNumber]) async {
    final String arJsonPath =
        '$currentBookDir/ar_${bookNumber ?? currentBookNumber}.json';

    final data =
        json.decode(await rootBundle.loadString(arJsonPath, cache: false));
    final hadiths =
        List.generate(data.length, (i) => ARHadithModel.fromJson(data[i]));
    // _tempArabicHadiths = hadiths;
    return hadiths;
  }

  Future<void> getHadithsForTheCurrentBookFor2ndLang(
      [String? bookNumber]) async {
    tempEnglishHadiths.clear();
    String currentLang = getCurrentLangName();
    if (currentLang == 'ar') currentLang = 'en';
    final String secondJsonPath =
        '$currentBookDir/${currentLang}_${bookNumber ?? currentBookNumber}.json';
    String jsonAsString = '';
    try {
      jsonAsString = await rootBundle.loadString(secondJsonPath, cache: false);
    } catch (e) {
      log('$e');
    }
    if (jsonAsString != '') {
      final data = json.decode(jsonAsString);
      tempEnglishHadiths.value = List.generate(data.length, (i) {
        return switch (currentLang) {
          'en' => ENHadithModel.fromJson(data[i]),
          // 'ar' => URHadithModel.fromJson(data[i]),
          // 'ba' => BNHadithModel.fromJson(data[i]),
          _ => ENHadithModel.fromJson(data[i]),
        };
      });
    }
  }

  Future<void> getAndSetHadiths() async {
    for (final book in currentCollection.booksNames) {
      final hadith = await arabicHadithsBox
          .get('${currentCollection.name}_${book['book_number']}_1}');
      if (hadith != null) _tempArabicHadiths.add(hadith);
    }
    log((await arabicHadithsBox.getAt(1))!.hadithText);

    log('hadiths length => ${_tempArabicHadiths.length}');
  }
}
