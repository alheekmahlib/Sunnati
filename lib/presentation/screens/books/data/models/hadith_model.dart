class Hadith {
  int arabicURN;
  String collection;
  int volumeNumber;
  int bookNumber;
  String babNumber;
  String hadithNumber;
  String bookName;
  String babName;
  String hadithText;
  dynamic annotations;
  String bookID;
  String grade1;
  int ourHadithNumber;
  int matchingEnglishURN;
  dynamic lastUpdated;

  Hadith({
    required this.arabicURN,
    required this.collection,
    required this.volumeNumber,
    required this.bookNumber,
    required this.babNumber,
    required this.hadithNumber,
    required this.bookName,
    required this.babName,
    required this.hadithText,
    this.annotations,
    required this.bookID,
    required this.grade1,
    required this.ourHadithNumber,
    required this.matchingEnglishURN,
    this.lastUpdated,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      arabicURN: json['arabicURN'],
      collection: json['collection'],
      volumeNumber: json['volumeNumber'],
      bookNumber: json['bookNumber'],
      babNumber: json['babNumber'],
      hadithNumber: json['hadithNumber'],
      bookName: json['bookName'],
      babName: json['babName'],
      hadithText: json['hadithText'],
      annotations: json['annotations'],
      bookID: json['bookID'],
      grade1: json['grade1'],
      ourHadithNumber: json['ourHadithNumber'],
      matchingEnglishURN: json['matchingEnglishURN'],
      lastUpdated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arabicURN': arabicURN,
      'collection': collection,
      'volumeNumber': volumeNumber,
      'bookNumber': bookNumber,
      'babNumber': babNumber,
      'hadithNumber': hadithNumber,
      'bookName': bookName,
      'babName': babName,
      'hadithText': hadithText,
      'annotations': annotations,
      'bookID': bookID,
      'grade1': grade1,
      'ourHadithNumber': ourHadithNumber,
      'matchingEnglishURN': matchingEnglishURN,
      'last_updated': lastUpdated,
    };
  }
}
