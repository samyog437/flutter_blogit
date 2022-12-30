import 'package:blogit/model/user.dart';
import 'package:blogit/data_source/local_data_source/user_data_source.dart';

abstract class UserRepository {
  Future<List<User>> getAllUser();
  Future<int> addUser(User user);
  Future<User?> loginUser(String username, String password);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(User user) {
    return UserDataSource().addUser(user);
  }

  @override
  Future<List<User>> getAllUser() {
    return UserDataSource().getAllUser();
  }

  @override
  Future<User?> loginUser(String username, String password) {
    return UserDataSource().loginUser(username, password);
  }
}
