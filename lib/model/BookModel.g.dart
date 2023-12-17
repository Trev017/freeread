// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      language: json['language'] as String,
      copyright_year: json['copyright_year'] as String,
      url_rss: json['url_rss'] as String,
      url_zip_file: json['url_zip_file'] as String,
      totaltimesecs: json['totaltimesecs'] as num,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'language': instance.language,
      'copyright_year': instance.copyright_year,
      'url_rss': instance.url_rss,
      'url_zip_file': instance.url_zip_file,
      'totaltimesecs': instance.totaltimesecs,
    };
