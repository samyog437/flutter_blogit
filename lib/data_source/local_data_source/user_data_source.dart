import 'package:blogit/helper/objectbox.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/state/objectbox_state.dart';

class UserDataSource {
  ObjectBoxInstance objectBoxInstance = ObjectBoxState.objectBoxInstance!;

  Future<int> addUser(User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return 0;
    }
  }

  Future<List<User>> getAllUser() {
    try {
      return Future.value(objectBoxInstance.getAllUser());
    } catch (e) {
      throw Exception('Error in getting all users');
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      if (objectBoxInstance.loginUser(username, password) != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error occured : ${e.toString()}');
    }
  }
}
