import 'package:objectbox/objectbox.dart';

@Entity()
class BookObjModel {
  @Id(assignable: true)
  int id;

  String bookName;
  String bookNumber;

  BookObjModel(
      {required this.id, required this.bookName, required this.bookNumber});

  factory BookObjModel.fromJson(Map<String, dynamic> json) {
    return BookObjModel(
      id: int.parse(json['book_number']),
      bookNumber: json['book_number'],
      bookName: json['book_name'],
    );
  }
}
