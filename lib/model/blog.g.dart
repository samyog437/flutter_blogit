// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
      json['_id'] as String,
      json['image'] as String,
      json['title'] as String,
      json['content'] as String,
      json['view'] as int,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.blogId,
      'image': instance.image,
      'title': instance.title,
      'content': instance.content,
      'view': instance.view,
    };
