import 'package:objectbox/objectbox.dart';

import 'collection_model.dart';

@Entity()
class URHadithModel {
  @Id(assignable: true)
  int id;
  ToOne<Collection> collection = ToOne<Collection>();
  final int volumeNumber;
  final int bookNumber;
  final String bookName;
  final String babNumber;
  final String? babName;
  final int hadithNumber;
  final String hadithText;
  final String bookID;
  final int ourHadithNumber;
  final int matchingArabicURN;
  final String lastUpdated;
  final int urduURN;
  final String? grade1;

  URHadithModel({
    required this.id,
    required this.urduURN,
    required this.grade1,
    required this.collection,
    required this.volumeNumber,
    required this.bookNumber,
    required this.bookName,
    required this.babNumber,
    required this.babName,
    required this.hadithNumber,
    required this.hadithText,
    required this.bookID,
    required this.ourHadithNumber,
    required this.matchingArabicURN,
    required this.lastUpdated,
  });

  factory URHadithModel.fromJson(Map<String, dynamic> json, int id) {
    return URHadithModel(
      id: id,
      urduURN: json['urduURN'],
      grade1: json['grade1'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'],
      bookName: json['bookName'],
      babNumber: json['babNumber'],
      babName: json['babName'],
      hadithNumber: int.tryParse(json['hadithNumber'].toString()) ?? 404,
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingArabicURN'],
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}
