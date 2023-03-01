import 'package:blogit/app/network_connectivity.dart';
import 'package:blogit/data_source/remote_data_source/user_data_source.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/data_source/local_data_source/user_data_source.dart';

abstract class UserRepository {
  Future<List<User>> getAllUser();
  Future<int> addUser(User user);
  Future<bool> loginUser(String username, String password);
  Future<List<User>> getUserData(String userId);
  Future<int> updateUser(User user);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(User user) {
    return UserRemoteDataSource().addUser(user);
  }

  @override
  Future<List<User>> getAllUser() {
    return UserDataSource().getAllUser();
  }

  @override
  Future<bool> loginUser(String username, String password) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().loginUser(username, password);
    } else {
      return UserDataSource().loginUser(username, password);
    }
  }

  @override
  Future<List<User>> getUserData(String userId) {
    return UserRemoteDataSource().getUserData(userId);
  }

  @override
  Future<int> updateUser(User user) {
    return UserRemoteDataSource().updateUser(user);
  }
}
