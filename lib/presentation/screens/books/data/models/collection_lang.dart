class CollectionLang {
  final String lang;
  final String title;
  final String shortIntro;

  CollectionLang({
    required this.lang,
    required this.title,
    required this.shortIntro,
  });

  factory CollectionLang.fromJson(Map<String, dynamic> json) {
    return CollectionLang(
      lang: json['lang'],
      title: json['title'],
      shortIntro: json['shortIntro'],
    );
  }
}
