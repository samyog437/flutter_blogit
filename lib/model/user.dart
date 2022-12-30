import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id(assignable: true)
  int userId;
  String username;
  String email;
  String password;

  User(this.username, this.email, this.password, {this.userId = 0});
}
