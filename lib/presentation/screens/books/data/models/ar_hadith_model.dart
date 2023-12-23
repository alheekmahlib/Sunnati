import 'package:hive/hive.dart';

part 'ar_hadith_model.g.dart';

@HiveType(typeId: 3)
class ARHadithModel extends HiveObject {
  @HiveField(0)
  final String collection;

  @HiveField(1)
  final int volumeNumber;

  @HiveField(2)
  final int bookNumber;

  @HiveField(3)
  final String bookName;

  @HiveField(4)
  final String babNumber;

  @HiveField(5)
  final String? babName;

  @HiveField(6)
  final int hadithNumber;

  @HiveField(7)
  final String hadithText;

  @HiveField(8)
  final String bookID;

  @HiveField(9)
  final int ourHadithNumber;

  @HiveField(10)
  final int matchingArabicURN;

  @HiveField(11)
  final String lastUpdated;

  @HiveField(12)
  final int arabicURN;

  @HiveField(13)
  final List<String>? annotations;

  @HiveField(14)
  final String? grade1;

  ARHadithModel({
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

  factory ARHadithModel.fromJson(Map<String, dynamic> json) {
    return ARHadithModel(
      arabicURN: json['arabicURN'],
      annotations: json['annotations'] != null
          ? RegExp('"([^"]*)"')
              .allMatches(
                  json['annotations'].replaceAll(RegExp(r'<[^>]*>'), ''))
              .map((match) => match.group(1)!)
              .toList()
          : null,
      grade1: json['grade1'],
      collection: json['collection'],
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
