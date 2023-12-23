// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'en_hadith_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ENHadithModelAdapter extends TypeAdapter<ENHadithModel> {
  @override
  final int typeId = 4;

  @override
  ENHadithModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ENHadithModel(
      englishURN: fields[12] as int,
      grade1: fields[13] as String?,
      collection: fields[0] as String,
      volumeNumber: fields[1] as int,
      bookNumber: fields[2] as int,
      bookName: fields[3] as String,
      babNumber: fields[4] as String,
      babName: fields[5] as String?,
      hadithNumber: fields[6] as int,
      hadithText: fields[7] as String,
      bookID: fields[8] as String,
      ourHadithNumber: fields[9] as int,
      matchingArabicURN: fields[10] as int,
      lastUpdated: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ENHadithModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.collection)
      ..writeByte(1)
      ..write(obj.volumeNumber)
      ..writeByte(2)
      ..write(obj.bookNumber)
      ..writeByte(3)
      ..write(obj.bookName)
      ..writeByte(4)
      ..write(obj.babNumber)
      ..writeByte(5)
      ..write(obj.babName)
      ..writeByte(6)
      ..write(obj.hadithNumber)
      ..writeByte(7)
      ..write(obj.hadithText)
      ..writeByte(8)
      ..write(obj.bookID)
      ..writeByte(9)
      ..write(obj.ourHadithNumber)
      ..writeByte(10)
      ..write(obj.matchingArabicURN)
      ..writeByte(11)
      ..write(obj.lastUpdated)
      ..writeByte(12)
      ..write(obj.englishURN)
      ..writeByte(13)
      ..write(obj.grade1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ENHadithModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
