// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookModelClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      language: fields[3] as String,
      copyright_year: fields[4] as String,
      url_rss: fields[5] as String,
      totaltimesecs: fields[6] as num,
      author: (fields[7] as List).cast<dynamic>(),
      chapters: (fields[8] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.language)
      ..writeByte(4)
      ..write(obj.copyright_year)
      ..writeByte(5)
      ..write(obj.url_rss)
      ..writeByte(6)
      ..write(obj.totaltimesecs)
      ..writeByte(7)
      ..write(obj.author)
      ..writeByte(8)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
