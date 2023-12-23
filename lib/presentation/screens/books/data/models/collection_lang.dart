import 'package:hive_flutter/adapters.dart';

part 'collection_lang.g.dart';

@HiveType(typeId: 2)
class CollectionLang {
  @HiveField(1)
  final String lang;
  @HiveField(2)
  final String title;
  @HiveField(3)
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
