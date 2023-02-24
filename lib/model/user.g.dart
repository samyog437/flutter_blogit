// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      usrId: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      userId: json['userId'] as int? ?? 0,
    )..blog = (json['blog'] as List<dynamic>?)
        ?.map((e) => Blog.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      '_id': instance.usrId,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'blog': instance.blog,
    };
