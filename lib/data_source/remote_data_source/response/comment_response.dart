import 'package:blogit/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  bool? success;
  String? message;
  List<Comment>? data;

  CommentResponse({this.success, this.message, this.data});

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
