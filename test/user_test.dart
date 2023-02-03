import 'package:blogit/data_source/remote_data_source/user_data_source.dart';
import 'package:blogit/model/user.dart';
import 'package:blogit/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('User should be able to login', () async {
    bool expectedResult = true;
    String username = "testuser";
    String password = "password";
    bool actualResult =
        await UserRemoteDataSource().loginUser(username, password);
    expect(actualResult, expectedResult);
  });
  test('User should be registered', () async {
    int expectedResult = 1;
    User user = User(
      username: "testuser1",
      email: "test1@email.com",
      password: "password",
    );
    int actualResult = await UserRemoteDataSource().addUser(user);
    expect(actualResult, expectedResult);
  });
}
