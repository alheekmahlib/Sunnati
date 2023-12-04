import 'collection_lang.dart';

class CollectionModel {
  final String name;
  final String bookName;
  final String arAndEnName;
  final String bookNumber;
  final bool hasBooks;
  final bool hasChapters;
  final List<CollectionLang> collection;
  final int totalHadith;
  final int totalAvailableHadith;

  CollectionModel({
    required this.name,
    required this.bookName,
    required this.arAndEnName,
    required this.bookNumber,
    required this.hasBooks,
    required this.hasChapters,
    required this.collection,
    required this.totalHadith,
    required this.totalAvailableHadith,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      name: json['name'],
      bookName: json['bookName'],
      arAndEnName: json['arAndEnName'],
      bookNumber: json['bookNumber'],
      hasBooks: json['hasBooks'],
      hasChapters: json['hasChapters'],
      collection: (json['collection'] as List)
          .map((lang) => CollectionLang.fromJson(lang))
          .toList(),
      totalHadith: json['totalHadith'],
      totalAvailableHadith: json['totalAvailableHadith'],
    );
  }
}
