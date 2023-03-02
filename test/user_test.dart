import 'dart:io';

import 'package:blogit/app/constants.dart';
import 'package:blogit/data_source/remote_data_source/blog_data_source.dart';
import 'package:blogit/data_source/remote_data_source/comment_data_source.dart';
import 'package:blogit/data_source/remote_data_source/user_data_source.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/blog.dart';
import 'package:blogit/model/user.dart';
import 'package:dio/dio.dart';
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

    test('User should be registered', () async {
      int expectedResult = 1;
      User user = User(
        username: "testuser21",
        email: "test21@email.com",
        password: "password",
      );
      int actualResult = await UserRemoteDataSource().addUser(user);
      expect(actualResult, expectedResult);
    });

    test('Should update user information', () async {
      String userId = '63ee5e0963970e13e0bfa902';
      final user = User(
        usrId: userId,
        username: 'testuser22',
        email: 'test22@email.com',
        password: 'password',
      );
      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2VlNWUwOTYzOTcwZTEzZTBiZmE5MDIiLCJ1c2VybmFtZSI6InRlc3R1c2VyNyIsImVtYWlsIjoidGVzdDdAZW1haWwuY29tIiwicm9sZSI6IlVzZXIiLCJpYXQiOjE2Nzc3Mjg4MTAsImV4cCI6MTY4MDMyMDgxMH0.rMBeWnUot4q4piO0VBmLWY0oMthW_2GsaD1dksMpd9s";

      final result = await UserRemoteDataSource().updateUser(user);

      expect(result, 1);
    });

    test('Should return a User object', () async {
      String userId = '63dd2922b52fab97145272c5';
      final expectedResult = User(
        usrId: userId,
        username: 'testuser',
        email: 'testuser@email.com',
      );
      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2RkMjkyMmI1MmZhYjk3MTQ1MjcyYzUiLCJ1c2VybmFtZSI6InRlc3R1c2VyIiwiZW1haWwiOiJ0ZXN0dXNlckBlbWFpbC5jb20iLCJyb2xlIjoiVXNlciIsImlhdCI6MTY3NzcyOTM5MSwiZXhwIjoxNjgwMzIxMzkxfQ.aWIuvnk1NB245MMO-m3xa9OmIMgSrNl_XzRPR9m8rk8";

      final actualResult = await UserRemoteDataSource().getUserData(userId);
      expect(actualResult, isNotNull);
      expect(actualResult.usrId, expectedResult.usrId);
      expect(actualResult.username, expectedResult.username);
      expect(actualResult.email, expectedResult.email);
    });
  });

  group('Blog test', () {
    test('Blog should not be empty', () async {
      final expectedResult = isA<List<Blog>>();
      final actualResult = await BlogRemoteDataSource().getAllBlog();
      expect(actualResult, expectedResult);
    });

    test('Should add blog', () async {
      int expectedResult = 1;
      Blog blog = Blog(
        title: "This is test 1",
        content: "This is test content",
      );
      final file = File("photo.jpg");
      if (!file.existsSync()) {
        fail('File not found');
      }

      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2RjZjQ1ZDRiZDk1NGZhODdhNzc3ZGIiLCJ1c2VybmFtZSI6InRlc3R1c2VyMiIsImVtYWlsIjoidGVzdDJAZW1haWwuY29tIiwicm9sZSI6IlVzZXIiLCJpYXQiOjE2Nzc0OTAwODIsImV4cCI6MTY4MDA4MjA4Mn0.YSODaKG8-4T4ziUtzlXJ9L1TEZEO67wbexzXs_L96P4";

      int actualResult = await BlogRemoteDataSource().createBlog(file, blog);
      expect(actualResult, expectedResult);
    });

    test('Should get a blog', () async {
      String blogId = "6400788c64653aeb75aafde5";

      Blog expectedResult = Blog(
        blogId: blogId,
        title: 'This is test 1',
        content: 'This is test content',
      );

      Blog? actualResult = await BlogRemoteDataSource().getABlog(blogId);
      expect(actualResult, isNotNull);
      expect(actualResult!.blogId, expectedResult.blogId);
      expect(actualResult.title, expectedResult.title);
      expect(actualResult.content, expectedResult.content);
    });

    test('Should edit a blog', () async {
      int expectedResult = 1;

      String blogId = "6400cf1c2b5a13f3ad20cec2";
      String userId = "63dcf45d4bd954fa87a777db";

      Blog originalBlog = Blog(
        blogId: blogId,
        title: 'This is test 1',
        content: 'This is test content',
        user: User(usrId: userId),
      );

      Blog updatedBlog = Blog(
        title: 'Updated title',
        content: 'Updated content',
      );

      final file = File("photo.jpg");

      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2RjZjQ1ZDRiZDk1NGZhODdhNzc3ZGIiLCJ1c2VybmFtZSI6InRlc3R1c2VyMiIsImVtYWlsIjoidGVzdDJAZW1haWwuY29tIiwicm9sZSI6IlVzZXIiLCJpYXQiOjE2Nzc0OTAwODIsImV4cCI6MTY4MDA4MjA4Mn0.YSODaKG8-4T4ziUtzlXJ9L1TEZEO67wbexzXs_L96P4";

      int actualResult = await BlogRemoteDataSource()
          .editBlog(file, updatedBlog, originalBlog, userId);
      expect(actualResult, expectedResult);
    });

    test('Should return 1 if comment is created successfully', () async {
      String blogId = "6400cf1c2b5a13f3ad20cec2";
      String comment = 'Great post!';

      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2RkMjkyMmI1MmZhYjk3MTQ1MjcyYzUiLCJ1c2VybmFtZSI6InRlc3R1c2VyIiwiZW1haWwiOiJ0ZXN0dXNlckBlbWFpbC5jb20iLCJyb2xlIjoiVXNlciIsImlhdCI6MTY3NzcyOTM5MSwiZXhwIjoxNjgwMzIxMzkxfQ.aWIuvnk1NB245MMO-m3xa9OmIMgSrNl_XzRPR9m8rk8";
      final commentDataSource = CommentRemoteDataSource();
      final actualResult =
          await commentDataSource.createComment(blogId, comment);
      expect(actualResult, 1);
    });

    test('Blog should not be empty', () async {
      String userId = '63dcf45d4bd954fa87a777db';
      final expectedResult = isA<List<Blog>>();
      final actualResult = await BlogRemoteDataSource().getAllUserBlog(userId);
      expect(actualResult, expectedResult);
      expect(actualResult.isNotEmpty, true);
    });

    test('Blog should be deleted', () async {
      int expectedResult = 1;

      String userId = '63dcf45d4bd954fa87a777db';
      final Blog blogToDelete = Blog(
        blogId: '6400cf1c2b5a13f3ad20cec2',
        user: User(usrId: userId),
        title: 'Updated title',
        content: 'Updated content',
      );
      Constant.token =
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2RjZjQ1ZDRiZDk1NGZhODdhNzc3ZGIiLCJ1c2VybmFtZSI6InRlc3R1c2VyMiIsImVtYWlsIjoidGVzdDJAZW1haWwuY29tIiwicm9sZSI6IlVzZXIiLCJpYXQiOjE2Nzc0OTAwODIsImV4cCI6MTY4MDA4MjA4Mn0.YSODaKG8-4T4ziUtzlXJ9L1TEZEO67wbexzXs_L96P4";

      final actualResult =
          await BlogRemoteDataSource().deleteBlog(blogToDelete, userId);
      expect(actualResult, expectedResult);
    });
  });
}
