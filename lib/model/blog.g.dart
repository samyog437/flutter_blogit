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
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.blogId,
      'image': instance.image,
      'title': instance.title,
      'content': instance.content,
      'view': instance.view,
      'comments': instance.comments,
      'user': instance.user,
    };
