import 'package:blogit/model/user.dart';
import 'package:blogit/objectbox.g.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'blog.g.dart';

// flutter pub run build_runner build  --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class Blog {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String blogId;
  String title;
  String content;

  @Backlink()
  final user = ToMany<User>();

  Blog(this.blogId, this.title, this.content, {this.id = 0});

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  Map<String, dynamic> toJson() => _$BlogToJson(this);
}