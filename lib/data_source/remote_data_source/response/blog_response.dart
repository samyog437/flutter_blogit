import 'package:blogit/model/blog.dart';
import 'package:json_annotation/json_annotation.dart';
part 'blog_response.g.dart';

@JsonSerializable()
class BlogResponse {
  bool? success;
  String? message;
  List<Blog>? data;

  BlogResponse({this.success, this.message, this.data});

  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}
