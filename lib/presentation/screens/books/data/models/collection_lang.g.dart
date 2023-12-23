// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_lang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionLangAdapter extends TypeAdapter<CollectionLang> {
  @override
  final int typeId = 2;

  @override
  CollectionLang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionLang(
      lang: fields[1] as String,
      title: fields[2] as String,
      shortIntro: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionLang obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.lang)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.shortIntro);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionLangAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
