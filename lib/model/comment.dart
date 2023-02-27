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
  @JsonKey(name: 'commenter_id')
  User? commenterId;

  String? body;

  Comment({this.body, this.commenterId, this.id = 0});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
