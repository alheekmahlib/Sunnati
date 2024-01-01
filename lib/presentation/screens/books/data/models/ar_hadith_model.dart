import 'package:objectbox/objectbox.dart';

import 'collection_model.dart';

@Entity()
class ARHadithModel {
  @Id(assignable: true)
  int id;
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
  final int arabicURN;
  final List<String>? annotations;
  final String? grade1;
  ToOne<Collection> collection = ToOne<Collection>();
  ARHadithModel({
    required this.id,
    required this.arabicURN,
    required this.annotations,
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
  factory ARHadithModel.fromJson(
      Map<String, dynamic> json, int id, Collection collection) {
    return ARHadithModel(
      id: id,
      arabicURN: json['arabicURN'],
      annotations: json['annotations'] != null
          ? RegExp('"([^"]*)"')
              .allMatches(
                  json['annotations'].replaceAll(RegExp(r'<[^>]*>'), ''))
              .map((match) => match.group(1)!)
              .toList()
          : null,
      grade1: json['grade1'],
      collection: ToOne<Collection>()..target = collection,
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'],
      bookName: json['bookName'],
      babNumber: json['babNumber'] ?? '404',
      babName: json['babName'],
      hadithNumber: int.tryParse(json['hadithNumber'].toString()) ?? 404,
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingEnglishURN'],
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}
