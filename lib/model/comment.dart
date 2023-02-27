import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/objectbox.g.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'comment.g.dart';

@Entity()
@JsonSerializable()
class Comment {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? commentId;

  String? date;

  final blogs = ToOne<Blog>();

  String? body;
  String? commenterName;

  Comment(
      {this.commentId, this.body, this.commenterName, this.date, this.id = 0});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
