// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentId: json['_id'] as String?,
      body: json['body'] as String?,
      commenterName: json['commenterName'] as String?,
      date: json['date'] as String?,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.commentId,
      'date': instance.date,
      'body': instance.body,
      'commenterName': instance.commenterName,
    };
