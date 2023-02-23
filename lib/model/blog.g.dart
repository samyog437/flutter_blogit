// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
      blogId: json['_id'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      view: json['view'] as int?,
      users: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.blogId,
      'image': instance.image,
      'title': instance.title,
      'content': instance.content,
      'view': instance.view,
      'user': instance.users,
    };
