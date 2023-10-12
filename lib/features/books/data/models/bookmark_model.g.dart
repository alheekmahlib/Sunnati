// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkAdapter extends TypeAdapter<Bookmark> {
  @override
  final int typeId = 0;

  @override
  Bookmark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmark(
      bookName: fields[0] as String,
      bookNumber: fields[1] as String,
      bookOtherName: fields[2] as String,
      chapterTitle: fields[3] as String,
      hadith: fields[4] as String,
      hadithNumber: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bookmark obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bookName)
      ..writeByte(1)
      ..write(obj.bookNumber)
      ..writeByte(2)
      ..write(obj.bookOtherName)
      ..writeByte(3)
      ..write(obj.chapterTitle)
      ..writeByte(4)
      ..write(obj.hadith)
      ..writeByte(5)
      ..write(obj.hadithNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
