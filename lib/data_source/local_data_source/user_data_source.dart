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

  Future<List<User>> getAllUser() async {
    try {
      return Future.value(objectBoxInstance.getAllUser());
    } catch (e) {
      throw Exception('Error in getting all users');
    }
  }
}
