import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/enums.dart';
import '../../core/utils/constants/lists.dart';
import '../screens/books/data/models/ar_hadith_model.dart';
import '../screens/books/data/models/bn_hadith_model.dart';
import '../screens/books/data/models/collection_model.dart';
import '../screens/books/data/models/en_hadith_model.dart';
import '../screens/books/data/models/ur_hadith_model.dart';
import '/objectbox.g.dart';
import 'general_controller.dart';
import 'objectbox.dart';

class BooksController extends GetxController {
  // final prefs = sl<SharedPreferences>();
  final generalCtrl = sl<GeneralController>();
  bool enableCaching = false;

  final List<Collection> _allCollections = [];

  RxList<ARHadithModel> tempArabicHadiths = <ARHadithModel>[].obs;
  RxList<ENHadithModel> tempEnglishHadiths = <ENHadithModel>[].obs;
  RxList<URHadithModel> tempUrduHadiths = <URHadithModel>[].obs;
  RxList<BNHadithModel> tempBanglaHadiths = <BNHadithModel>[].obs;

  int _currentCollectionId = 1;
  int get currentCollectionId => _currentCollectionId;
  set currentCollctionId(int newId) => _currentCollectionId = newId;
  int getCollectionIdByAuthorName(String collectionName) =>
      Authors.values.indexWhere((col) => col.name == collectionName) + 1;
  set setCurrentCollectionIdbyAuthorName(String authorName) =>
      _currentCollectionId =
          _allCollections.firstWhere((col) => col.name == authorName).id;
  int currentBookNumber = 1;

  final Rx<ScrollController> chaptersListViewController =
      ScrollController().obs;

  /// * [Boxes]
  late Store store;

  void _setStore(Store store) => this.store = store;

  // int currentHadithsQueryOffset = 0;

  @override
  void onInit() async {
    _setStore((await ObjBox.create()).store);
    await loadBooksData();
    await Future.delayed(const Duration(milliseconds: 500));
    await storeJsonDataToObjectBox();
    chaptersListViewController.value.addListener(() async {
      if (chaptersListViewController.value.position.maxScrollExtent ==
          chaptersListViewController.value.offset) {
        getAndSetMoreHadiths();
      } else {
        log('position.maxScrollExtent=> ${chaptersListViewController.value.position.maxScrollExtent}');
      }
    });
    super.onInit();
  }

  Color booksColor(int index) =>
      index == 5 ? const Color(0xffE6DAC8) : Colors.transparent;

  List<Collection> get allCollections => _allCollections;
  List<List<ARHadithModel>> get currentBookChapters {
    final Map<String, List<ARHadithModel>> groupedMap = {};
    for (var hadith in tempArabicHadiths) {
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
      'assets/json/books_data/${currentCollection.name}_books';

  String get currentBookName => currentCollection.booksNames
      .firstWhere((e) => int.parse(e.bookNumber) == currentBookNumber)
      .bookName;
  // * [Book Screen]
  Collection get currentCollection =>
      _allCollections.firstWhere((col) => col.id == _currentCollectionId);

  //* book chapters
  RxList<ARHadithModel> get arabicHadiths {
    // if (tempArabicHadiths.value.isEmpty) getAndSetMoreHadiths();
    return tempArabicHadiths;
  }

  void clearHadithsAndGetNewOnes() => this
    ..tempArabicHadiths.clear()
    ..getAndSetMoreHadiths();

  String getHadithTranslationByURN(int arabicURN) =>
      tempEnglishHadiths
          .firstWhereOrNull((h) => h.matchingArabicURN == arabicURN)
          ?.hadithText ??
      'NOT_FOUNd';
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
          Collection.fromJson(
              item, getCollectionIdByAuthorName(item['name']))));
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
    for (final col in [_allCollections[1]]) {
      col.booksNames.sort((a, b) => a.bookNumber.compareTo(b.bookNumber));
      collectionsBox.put(col);
      // [2] Hadiths
      setCurrentCollectionIdbyAuthorName = col.name;
      for (final book in col.booksNames) {
        _getHadithsForTheCurrentBook(col.id, book.bookNumber);
        getHadithsForTheCurrentBookFor2ndLang(col.id, book.bookNumber);
        log('${col.name}_${book.bookNumber}');
      }
    }
  }

  Future<List<ARHadithModel>> getAndSetArabicHadithsForCurrentbook() async =>
      (store
              .box<ARHadithModel>()
              .query(ARHadithModel_.bookNumber.equals(currentBookNumber))
              .build()
            ..offset = tempArabicHadiths.length
            ..limit = 10)
          .findAsync();

  Future<List<ENHadithModel>> getAndSetEnglishHadithsForCurrentbook() async =>
      await (store
              .box<ENHadithModel>()
              .query(ENHadithModel_.bookNumber.equals(currentBookNumber))
              .build()
            ..offset = tempEnglishHadiths.length
            ..limit = 10)
          .findAsync();

  Future<List<ARHadithModel>> _getHadithsForTheCurrentBook(
      int collectionId, String bookNumber) async {
    if (bookNumber == '0') {
      log('Collection $collectionId has Book number 0');
    }
    final String arJsonPath = '$currentBookPath/ar_$bookNumber.json';
    if (!await doesAssetExist(arJsonPath)) return [];
    final arabicHadithsBox = store.box<ARHadithModel>();
    try {
      final data =
          json.decode(await rootBundle.loadString(arJsonPath, cache: false));
      final hadiths = List.generate(
          data.length, (i) => ARHadithModel.fromJson(data[i], i, collectionId));
      arabicHadithsBox.putMany(hadiths);
      return hadiths;
    } catch (e) {
      log('Error loading data: $e');
    }
    return [];
  }

  Future<void> getHadithsForTheCurrentBookFor2ndLang(
      int collectionId, String bookNumber) async {
    tempEnglishHadiths.clear();
    String currentLang = currentLangName;
    if (currentLang == 'ar') currentLang = 'en';
    final String secondJsonPath =
        '$currentBookPath/${currentLang}_$bookNumber.json';
    String jsonAsString = '';
    if (!await doesAssetExist(secondJsonPath)) return;
    try {
      jsonAsString = await rootBundle.loadString(secondJsonPath, cache: false);
    } catch (e) {
      log('$e');
    }
    if (jsonAsString != '') {
      final data = json.decode(jsonAsString);

      switch (currentLang) {
        case 'en':
          tempEnglishHadiths.value = List.generate(data.length,
              (i) => ENHadithModel.fromJson(data[i], i, collectionId));
        case 'ur':
          tempUrduHadiths.value = List.generate(data.length,
              (i) => URHadithModel.fromJson(data[i], i, collectionId));
        case 'bn':
          tempBanglaHadiths.value = List.generate(data.length,
              (i) => BNHadithModel.fromJson(data[i], i, collectionId));
      }
    }
  }

  Future<void> getAndSetMoreHadiths([bool firstTime = false]) async {
    await Future.wait([
      getAndSetArabicHadithsForCurrentbook().then((v) {
        return tempArabicHadiths.addAll(v);
      }),
      // TODO: check if the pagination works as expected for all languages
      getAndSetEnglishHadithsForCurrentbook()
          .then((v) => tempEnglishHadiths.addAll(v))
    ]);

    log('Total hadiths so far: ${tempArabicHadiths.length}');
    // return hadiths;
  }
}

extension SearchHelper on BooksController {
  Future<List<ARHadithModel>> searchForHadithsByStringQuery(
      String searchQuery, List<int> selectedCollectionsIds) async {
    return await store
        .box<ARHadithModel>()
        .query(ARHadithModel_.arabicURN
            .equals(int.tryParse(searchQuery) ?? 0)
            .or(ARHadithModel_.hadithText
                .contains(searchQuery, caseSensitive: false)))
        .build()
        .findAsync();
  }
}
