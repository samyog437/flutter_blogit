import 'package:blogit/model/blog.dart';
import 'package:blogit/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int userId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? usrId;
  String? username;
  String? email;
  String? password;

  List<Blog>? blog;
  List<Comment>? comment;

  final comments = ToMany<Comment>();

  User({
    this.usrId,
    this.username,
    this.email,
    this.password,
    this.userId = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
