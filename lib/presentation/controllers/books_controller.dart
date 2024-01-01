import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/enums.dart';
import '../../core/utils/constants/lists.dart';
import '../screens/books/data/models/ar_hadith_model.dart';
import '../screens/books/data/models/collection_model.dart';
import '../screens/books/data/models/en_hadith_model.dart';
import '/objectbox.g.dart';
import 'general_controller.dart';
import 'objectbox.dart';

class BooksController extends GetxController {
  // final prefs = sl<SharedPreferences>();
  final generalCtrl = sl<GeneralController>();
  bool enableCaching = false;

  final List<Collection> _allCollections = [];

  final List<ARHadithModel> _tempArabicHadiths = [];
  RxList<ENHadithModel> tempEnglishHadiths = <ENHadithModel>[].obs;

  int _currentCollectionIndex = 0;
  int get currentCollectionIndex => _currentCollectionIndex;
  set currentCollctionIndex(int index) => _currentCollectionIndex = index;
  int getCollectionIndexByName(String collectionName) => Authors.values
      .indexWhere((Authors author) => author.name == collectionName);
  set setCurrentCollectionIndexAuthorName(String authorName) =>
      _currentCollectionIndex = Authors.values
          .indexWhere((Authors author) => author.name == authorName);
  int getCurrentCollectionIndexAuthorName(String authorName) =>
      _currentCollectionIndex = Authors.values
          .indexWhere((Authors author) => author.name == authorName);
  int currentBookNumber = 1;

  /// * [Boxes]
  late Store store;

  void _setStore(Store store) => this.store = store;

  @override
  void onInit() async {
    _setStore((await ObjBox.create()).store);
    await loadBooksData();
    await Future.delayed(const Duration(milliseconds: 500));
    await storeJsonDataToObjectBox();

    super.onInit();
  }

  Color booksColor(int index) =>
      index == 5 ? const Color(0xffE6DAC8) : Colors.transparent;

  // *  [HOME]  *
  // Hadith get lastReadedHadith => ...
  // Hadith get hadithOfTheDay => ...

  // * [All Collections]

  List<Collection> get allCollections => _allCollections;
  List<List<ARHadithModel>> get currentBookChapters {
    final Map<String, List<ARHadithModel>> groupedMap = {};
    for (var hadith in _tempArabicHadiths) {
      if (groupedMap.containsKey(hadith.babNumber)) {
        groupedMap[hadith.babNumber]!.add(hadith);
      } else {
        groupedMap[hadith.babNumber] = [hadith];
      }
    }
    log('chapters loaded');
    final List<List<ARHadithModel>> hadiths = [];
    hadiths.addAll(groupedMap.values);
    return hadiths;
  }

  // * [All Books]
  String get currentBookPath =>
      'assets/json/books_data/${_allCollections[currentCollectionIndex].name}_books';
  String get currentBookHiveKey =>
      '${_allCollections[currentCollectionIndex].name}_$currentBookNumber';

  String get currentBookName => currentCollection.booksNames
      .firstWhere((e) => int.parse(e.bookNumber) == currentBookNumber)
      .bookName;
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

extension MoreDetails on Collection {
  String get currentBookAbout =>
      sl<BooksController>()
          .currentCollection
          .collectionLangs
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
      _allCollections.assignAll(jsonData.toList().map((item) =>
          Collection.fromJson(item, getCollectionIndexByName(item['name']))));
      log("Collections Length: ${_allCollections.length}");
    } catch (e) {
      log('Error loading data: $e');
    }
  }

  String get currentLangName => generalCtrl.currentLang.toLowerCase();

  Future<bool> doesAssetExist(String assetPath) async {
    try {
      // Attempt to load the asset
      await rootBundle.load(assetPath);
      return true; // Asset exists
    } catch (_) {
      return false; // Asset doesn't exist
    }
  }

  Future<void> storeJsonDataToObjectBox() async {
    // final Directory dir = await getApplicationDocumentsDirectory();

    final collectionsBox = store.box<Collection>();
    for (final col in _allCollections) {
      col.booksNames.sort((a, b) => a.bookNumber.compareTo(b.bookNumber));
      collectionsBox.put(col);
      // [2] Hadiths
      setCurrentCollectionIndexAuthorName = col.name;
      for (final book in col.booksNames) {
        _getHadithsForTheCurrentBook(col.name, book.bookNumber);
        log('${col.name}_${book.bookNumber}');
      }
    }
  }

  Future<List<ARHadithModel>> getAndSetHadithsForCurrentbook() async => store
      .box<ARHadithModel>()
      .query(ARHadithModel_.bookNumber.equals(currentBookNumber))
      .build()
      .findAsync();

  Future<List<ARHadithModel>> _getHadithsForTheCurrentBook(
      String collectionName, String bookNumber) async {
    if (bookNumber == '0') {
      log('Collection $collectionName has Book number 0');
    }
    final String arJsonPath = '$currentBookPath/ar_$bookNumber.json';
    if (!await doesAssetExist(arJsonPath)) return [];
    final arabicHadithsBox = store.box<ARHadithModel>();
    try {
      final data =
          json.decode(await rootBundle.loadString(arJsonPath, cache: false));
      final hadiths = List.generate(
          data.length,
          (i) => ARHadithModel.fromJson(data[i], i,
              _allCollections.firstWhere((col) => col.name == collectionName)));
      arabicHadithsBox.putMany(hadiths);
      return hadiths;
    } catch (e) {
      log('Error loading data: $e');
    }
    return [];
  }

  Future<void> getHadithsForTheCurrentBookFor2ndLang(
      [String? bookNumber]) async {
    tempEnglishHadiths.clear();
    String currentLang = currentLangName;
    if (currentLang == 'ar') currentLang = 'en';
    final String secondJsonPath =
        '$currentBookPath/${currentLang}_${bookNumber ?? currentBookNumber}.json';
    String jsonAsString = '';
    if (!await doesAssetExist(secondJsonPath)) return;
    try {
      jsonAsString = await rootBundle.loadString(secondJsonPath, cache: false);
    } catch (e) {
      log('$e');
    }
    if (jsonAsString != '') {
      final data = json.decode(jsonAsString);
      tempEnglishHadiths.value = List.generate(data.length, (i) {
        return switch (currentLang) {
          'en' => ENHadithModel.fromJson(data[i], i),
          // 'ar' => URHadithModel.fromJson(data[i]),
          // 'ba' => BNHadithModel.fromJson(data[i]),
          _ => ENHadithModel.fromJson(data[i], i),
        };
      });
    }
  }

  Future<List<ARHadithModel>> getAndSetHadiths() async {
    final arabicHadithsBox = store.box<ARHadithModel>();
    final List<ARHadithModel> hadiths = await arabicHadithsBox
        .query(ARHadithModel_.bookNumber.equals(currentBookNumber))
        .build()
        .findAsync();
    _tempArabicHadiths
      ..clear()
      ..addAll(hadiths);
    log('Total hadiths so far: ${_tempArabicHadiths.length}');
    return hadiths;
  }
}
