// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final int typeId = 1;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collection(
      name: fields[1] as String,
      bookName: fields[2] as String,
      arAndEnName: fields[3] as String,
      bookNumber: fields[4] as int,
      hasBooks: fields[5] as bool,
      hasChapters: fields[6] as bool,
      collection: (fields[7] as List).cast<CollectionLang>(),
      totalHadith: fields[8] as int,
      totalAvailableHadith: fields[9] as int,
      booksNames: (fields[10] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(10)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.bookName)
      ..writeByte(3)
      ..write(obj.arAndEnName)
      ..writeByte(4)
      ..write(obj.bookNumber)
      ..writeByte(5)
      ..write(obj.hasBooks)
      ..writeByte(6)
      ..write(obj.hasChapters)
      ..writeByte(7)
      ..write(obj.collection)
      ..writeByte(8)
      ..write(obj.totalHadith)
      ..writeByte(9)
      ..write(obj.totalAvailableHadith)
      ..writeByte(10)
      ..write(obj.booksNames);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
