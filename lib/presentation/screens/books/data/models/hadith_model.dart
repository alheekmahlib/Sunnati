abstract class HadithBaseModel {
  final String collection;
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

  HadithBaseModel({
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

  factory HadithBaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError(
        'fromJson is not implemented for the base class HadithBaseModel');
  }
}

class HadithArabicModel extends HadithBaseModel {
  final int arabicURN;
  final List<String>? annotations;
  final String? grade1;

  HadithArabicModel({
    required this.arabicURN,
    required this.annotations,
    required this.grade1,
    required String collection,
    required int volumeNumber,
    required int bookNumber,
    required String bookName,
    required String babNumber,
    required String? babName,
    required int hadithNumber,
    required String hadithText,
    required String bookID,
    required int ourHadithNumber,
    required int matchingArabicURN,
    required String lastUpdated,
  }) : super(
          collection: collection,
          volumeNumber: volumeNumber,
          bookNumber: bookNumber,
          bookName: bookName,
          babNumber: babNumber,
          babName: babName,
          hadithNumber: hadithNumber,
          hadithText: hadithText,
          bookID: bookID,
          ourHadithNumber: ourHadithNumber,
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );
  @override
  factory HadithArabicModel.fromJson(Map<String, dynamic> json) {
    return HadithArabicModel(
      arabicURN: json['arabicURN'],
      annotations: json['annotations'] != null
          ? List<String>.from(json['annotations'])
          : null,
      grade1: json['grade1'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'],
      bookName: json['bookName'],
      babNumber: json['babNumber'],
      babName: json['babName'],
      hadithNumber: int.tryParse(json['hadithNumber']) ?? 404,
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingEnglishURN'],
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}

class HadithEnglishModel extends HadithBaseModel {
  final int englishURN;
  final String? grade1;
  final String grade2;
  final String comments;

  HadithEnglishModel({
    required this.englishURN,
    required this.grade1,
    required this.grade2,
    required this.comments,
    required String collection,
    required int volumeNumber,
    required int bookNumber,
    required String bookName,
    required String babNumber,
    required String? babName,
    required int hadithNumber,
    required String hadithText,
    required String bookID,
    required int ourHadithNumber,
    required int matchingArabicURN,
    required String lastUpdated,
  }) : super(
          collection: collection,
          volumeNumber: volumeNumber,
          bookNumber: bookNumber,
          bookName: bookName,
          babNumber: babNumber,
          babName: babName,
          hadithNumber: hadithNumber,
          hadithText: hadithText,
          bookID: bookID,
          ourHadithNumber: ourHadithNumber,
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );

  @override
  factory HadithEnglishModel.fromJson(Map<String, dynamic> json) {
    return HadithEnglishModel(
      englishURN: json['englishURN'],
      grade1: json['grade1'],
      grade2: json['grade2'],
      comments: json['comments'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'] ?? 404, // errror
      bookName: json['bookName'],
      babNumber: json['babNumber'] ?? '404',
      babName: json['babName'] ?? 'Chapter',
      hadithNumber: json['hadithNumber'],
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingArabicURN'],
      lastUpdated: json['last_updated'],
    );
  }
}

class HadithBanglaModel extends HadithBaseModel {
  final int banglaURN;
  final String? hadithSanad;
  final String grade;

  HadithBanglaModel({
    required this.banglaURN,
    required this.hadithSanad,
    required this.grade,
    required String collection,
    required int volumeNumber,
    required int bookNumber,
    required String bookName,
    required String babNumber,
    required String? babName,
    required int hadithNumber,
    required String hadithText,
    required String bookID,
    required int ourHadithNumber,
    required int matchingArabicURN,
    required String lastUpdated,
  }) : super(
          collection: collection,
          volumeNumber: volumeNumber,
          bookNumber: bookNumber,
          bookName: bookName,
          babNumber: babNumber,
          babName: babName,
          hadithNumber: hadithNumber,
          hadithText: hadithText,
          bookID: bookID,
          ourHadithNumber: ourHadithNumber,
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );

  @override
  factory HadithBanglaModel.fromJson(Map<String, dynamic> json) {
    return HadithBanglaModel(
      banglaURN: json['banglaURN'],
      hadithSanad: json['hadithSanad'],
      grade: json['grade'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'] ?? 404, // errror
      bookName: json['bookName'],
      babNumber: json['babNumber'] ?? '404',
      babName: json['babName'] ?? 'Chapter',
      hadithNumber: json['hadithNumber'],
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingArabicURN'],
      lastUpdated: json['last_updated'],
    );
  }
}

class HadithUrduModel extends HadithBaseModel {
  final int urduURN;
  final String? hadithSanad;
  final String grade;

  HadithUrduModel({
    required this.urduURN,
    required this.hadithSanad,
    required this.grade,
    required String collection,
    required int volumeNumber,
    required int bookNumber,
    required String bookName,
    required String babNumber,
    required String? babName,
    required int hadithNumber,
    required String hadithText,
    required String bookID,
    required int ourHadithNumber,
    required int matchingArabicURN,
    required String lastUpdated,
  }) : super(
          collection: collection,
          volumeNumber: volumeNumber,
          bookNumber: bookNumber,
          bookName: bookName,
          babNumber: babNumber,
          babName: babName,
          hadithNumber: hadithNumber,
          hadithText: hadithText,
          bookID: bookID,
          ourHadithNumber: ourHadithNumber,
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );
  @override
  factory HadithUrduModel.fromJson(Map<String, dynamic> json) {
    return HadithUrduModel(
      urduURN: json['urduURN'],
      hadithSanad: json['hadithSanad'],
      grade: json['grade'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'] ?? 404, // errror
      bookName: json['bookName'],
      babNumber: json['babNumber'] ?? '404',
      babName: json['babName'] ?? 'Chapter',
      hadithNumber: json['hadithNumber'],
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingArabicURN'],
      lastUpdated: json['last_updated'],
    );
  }
}
