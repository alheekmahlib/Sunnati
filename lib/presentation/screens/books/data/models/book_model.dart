import 'book_lang.dart';

class Book {
  final String name;
  final String bookName;
  final String arAndEnName;
  final int bookNumber;
  final bool hasBooks;
  final bool hasChapters;
  final List<CollectionLang> collection;
  final int totalHadith;
  final int totalAvailableHadith;

  Book({
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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'],
      bookName: json['bookName'] ?? 'book name',
      arAndEnName: json['arAndEnName'] ?? 'book ar and en name',
      // FIXME:
      bookNumber: 1, //int.parse(json['bookNumber']!),
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
