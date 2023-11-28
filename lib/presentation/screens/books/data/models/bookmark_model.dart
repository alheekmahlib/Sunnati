import 'package:hive/hive.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 0)
class Bookmark {
  @HiveField(0)
  final String bookName;

  @HiveField(1)
  final String bookNumber;

  @HiveField(2)
  final String bookOtherName;

  @HiveField(3)
  final String chapterTitle;

  @HiveField(4)
  final String hadith;

  @HiveField(5)
  final String hadithNumber;

  Bookmark(
      {required this.bookName,
      required this.bookNumber,
      required this.bookOtherName,
      required this.chapterTitle,
      required this.hadith,
      required this.hadithNumber});
}
