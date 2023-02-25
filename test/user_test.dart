import 'package:blogit/data_source/remote_data_source/blog_data_source.dart';
import 'package:blogit/data_source/remote_data_source/user_data_source.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User test', () {
    test('User should be able to login', () async {
      bool expectedResult = true;
      String username = "testuser";
      String password = "password";
      bool actualResult =
          await UserRemoteDataSource().loginUser(username, password);
      expect(actualResult, expectedResult);
    });

    test('User should not be able to login', () async {
      bool expectedResult = false;
      String username = "testuserasdas";
      String password = "passwordasds";
      bool actualResult =
          await UserRemoteDataSource().loginUser(username, password);
      expect(actualResult, expectedResult);
    });

    test('User should be registered', () async {
      int expectedResult = 1;
      User user = User(
        username: "testuser7",
        email: "test7@email.com",
        password: "password",
      );
      int actualResult = await UserRemoteDataSource().addUser(user);
      expect(actualResult, expectedResult);
    });

    test('User should not be registered', () async {
      int expectedResult = 0;
      User user = User(
        username: "testuser3",
        email: "test3@email.com",
        password: "password",
      );
      int actualResult = await UserRemoteDataSource().addUser(user);
      expect(actualResult, expectedResult);
    });
  });

  group('Blog test', () {
    test('Blog should not be empty', () async {
      final expectedResult = isA<List<Blog>>();
      final actualResult = await BlogRemoteDataSource().getAllBlog();
      expect(actualResult, expectedResult);
    });

    test('Should add blog', () async {});
  });
}
