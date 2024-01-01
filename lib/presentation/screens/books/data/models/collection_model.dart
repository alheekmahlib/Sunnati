import 'package:objectbox/objectbox.dart';

import 'book_obj_model.dart';
import 'collection_lang.dart';

@Entity()
class Collection {
  @Id(assignable: true)
  int id;
  final String name;
  final String bookName;
  final String arAndEnName;
  final bool hasBooks;
  final bool hasChapters;
  ToMany<CollectionLang> collectionLangs = ToMany<CollectionLang>();
  final int totalHadith;
  final int totalAvailableHadith;
  ToMany<BookObjModel> booksNames = ToMany<BookObjModel>();

  Collection({
    required this.id,
    required this.name,
    required this.bookName,
    required this.arAndEnName,
    required this.hasBooks,
    required this.hasChapters,
    required this.collectionLangs,
    required this.totalHadith,
    required this.totalAvailableHadith,
    required this.booksNames,
  });

  factory Collection.fromJson(Map<String, dynamic> json, int id) {
    return Collection(
      id: id,
      name: json['name'],
      bookName: json['bookName'] ?? 'book name',
      arAndEnName: json['arAndEnName'] ?? 'book ar and en name',
      hasBooks: json['hasBooks'],
      hasChapters: json['hasChapters'],
      collectionLangs: ToMany<CollectionLang>(
          items: List<CollectionLang>.from(
              json['collection'].map((lang) => CollectionLang.fromJson(
                    lang,
                  )))),
      totalHadith: json['totalHadith'],
      totalAvailableHadith: json['totalAvailableHadith'],
      booksNames: ToMany<BookObjModel>(
          items: List<BookObjModel>.from(json['books_names']
              .map((j) => BookObjModel.fromJson(j))
              .toList())), // TODO Sort the values
    );
  }
}
