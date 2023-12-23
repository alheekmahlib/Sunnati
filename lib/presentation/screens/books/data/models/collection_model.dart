import 'package:hive/hive.dart';

import 'collection_lang.dart';

part 'collection_model.g.dart';

@HiveType(typeId: 1)
class Collection {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String bookName;
  @HiveField(3)
  final String arAndEnName;
  @HiveField(4)
  final int bookNumber;
  @HiveField(5)
  final bool hasBooks;
  @HiveField(6)
  final bool hasChapters;
  @HiveField(7)
  final List<CollectionLang> collection;
  @HiveField(8)
  final int totalHadith;
  @HiveField(9)
  final int totalAvailableHadith;
  @HiveField(10)
  final List<Map<String, dynamic>> booksNames;

  Collection({
    required this.name,
    required this.bookName,
    required this.arAndEnName,
    required this.bookNumber,
    required this.hasBooks,
    required this.hasChapters,
    required this.collection,
    required this.totalHadith,
    required this.totalAvailableHadith,
    required this.booksNames,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      name: json['name'],
      bookName: json['bookName'] ?? 'book name',
      arAndEnName: json['arAndEnName'] ?? 'book ar and en name',
      // FIXME:
      bookNumber: int.tryParse(json['bookNumber']) ??
          404, //int.parse(json['bookNumber']!),
      hasBooks: json['hasBooks'],
      hasChapters: json['hasChapters'],
      collection: (json['collection'] as List)
          .map((lang) => CollectionLang.fromJson(lang))
          .toList(),
      totalHadith: json['totalHadith'],
      totalAvailableHadith: json['totalAvailableHadith'],
      booksNames: [...json['books_names']], // TODO Sort the values
    );
  }
}
