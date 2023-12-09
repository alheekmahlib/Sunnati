class HadithBaseModel {
  int urn;
  String collection;
  int volumeNumber;
  int bookNumber;
  String? bookName;
  dynamic babNumber; // Use dynamic to handle both int and string for babNumber
  String? babName;
  int hadithNumber;
  String hadithSanad;
  String hadithText;
  String bookID;
  String grade;
  String comments;
  int ourHadithNumber;
  int matchingArabicURN;
  String lastUpdated;

  HadithBaseModel({
    required this.urn,
    required this.collection,
    required this.volumeNumber,
    required this.bookNumber,
    required this.bookName,
    required this.babNumber,
    required this.babName,
    required this.hadithNumber,
    required this.hadithSanad,
    required this.hadithText,
    required this.bookID,
    required this.grade,
    required this.comments,
    required this.ourHadithNumber,
    required this.matchingArabicURN,
    required this.lastUpdated,
  });

  factory HadithBaseModel.fromJson(Map<String, dynamic> json) {
    return HadithBaseModel(
      urn: json['englishURN'] ??
          json['arabicURN'] ??
          json['urduURN'] ??
          json['banglaURN'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'],
      bookName: json['bookName'],
      babNumber: json['babNumber'],
      babName: json['babName'],
      hadithNumber: json['hadithNumber'],
      hadithSanad: json['hadithSanad'],
      hadithText: json['hadithText'],
      bookID: json['bookID'],
      grade: json['grade'],
      comments: json['comments'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingArabicURN: json['matchingArabicURN'],
      lastUpdated: json['last_updated'] ?? '', // Default value for null
    );
  }
}

class HadithEnglishModel extends HadithBaseModel {
  HadithEnglishModel({
    required int englishURN,
    required int matchingArabicURN,
    required String lastUpdated,
    required Map<String, dynamic> json,
  }) : super(
          urn: englishURN,
          collection: json['collection'],
          volumeNumber: json['volumeNumber'],
          bookNumber: json['bookNumber'],
          bookName: json['bookName'],
          babNumber: json['babNumber'],
          babName: json['babName'],
          hadithNumber: json['hadithNumber'],
          hadithSanad: '',
          hadithText: json['hadithText'],
          bookID: json['bookID'],
          grade: json['grade1'],
          comments: json['comments'],
          ourHadithNumber: json['ourHadithNumber'],
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );
}

class HadithArabicModel extends HadithBaseModel {
  HadithArabicModel({
    required int matchingEnglishURN,
    required String lastUpdated,
    required Map<String, dynamic> json,
  }) : super(
          urn: json['arabicURN'],
          collection: json['collection'],
          volumeNumber: json['volumeNumber'],
          bookNumber: json['bookNumber'],
          bookName: json['bookName'],
          babNumber: json['babNumber'],
          babName: json['babName'],
          hadithNumber: json['hadithNumber'],
          hadithSanad: '',
          hadithText: json['hadithText'],
          bookID: json['bookID'],
          grade: json['grade'],
          comments: json['comments'],
          ourHadithNumber: json['ourHadithNumber'],
          matchingArabicURN: json['matchingArabicURN'],
          lastUpdated: lastUpdated,
        );
}

class HadithUrduModel extends HadithBaseModel {
  HadithUrduModel({
    required int urduURN,
    required int matchingArabicURN,
    required String lastUpdated,
    required Map<String, dynamic> json,
  }) : super(
          urn: urduURN,
          collection: json['collection'],
          volumeNumber: json['volumeNumber'],
          bookNumber: json['bookNumber'],
          bookName: json['bookName'],
          babNumber: json['babNumber'],
          babName: json['babName'],
          hadithNumber: json['hadithNumber'],
          hadithSanad: json['hadithSanad'],
          hadithText: json['hadithText'],
          bookID: json['bookID'],
          grade: json['grade'],
          comments: json['comments'],
          ourHadithNumber: json['ourHadithNumber'],
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );
}

class HadithBanglaModel extends HadithBaseModel {
  HadithBanglaModel({
    required int banglaURN,
    required int matchingArabicURN,
    required String lastUpdated,
    required Map<String, dynamic> json,
  }) : super(
          urn: banglaURN,
          collection: json['collection'],
          volumeNumber: json['volumeNumber'],
          bookNumber: json['bookNumber'],
          bookName: null,
          babNumber: json['babNumber'],
          babName: null,
          hadithNumber: json['hadithNumber'],
          hadithSanad: '',
          hadithText: json['hadithText'],
          bookID: json['bookID'],
          grade: json['grade'],
          comments: json['comments'],
          ourHadithNumber: json['ourHadithNumber'],
          matchingArabicURN: matchingArabicURN,
          lastUpdated: lastUpdated,
        );
}
