// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      body: json['body'] as String?,
      commenterId: json['commenter_id'] == null
          ? null
          : User.fromJson(json['commenter_id'] as Map<String, dynamic>),
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'commenter_id': instance.commenterId,
      'body': instance.body,
    };
