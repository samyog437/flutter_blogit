import 'dart:io';

import 'package:blogit/data_source/remote_data_source/blog_data_source.dart';
import 'package:blogit/model/blog.dart';

abstract class BlogRepository {
  Future<List<Blog>> getAllBlog();
  Future<List<Blog>> getAllUserBlog(userid);
  Future<Blog?> getABlog(id);
  Future<int> createBlog(File? file, Blog blog);
  Future<int> editBlog(File? file, Blog updatedBlog, Blog blog, userId);
  Future<int> deleteBlog(Blog blog, userId);
}

class BlogRepositoryImpl extends BlogRepository {
  @override
  Future<List<Blog>> getAllBlog() {
    return BlogRemoteDataSource().getAllBlog();
  }

  @override
  Future<Blog?> getABlog(id) {
    return BlogRemoteDataSource().getABlog(id);
  }

  @override
  Future<int> createBlog(File? file, Blog blog) async {
    return BlogRemoteDataSource().createBlog(file, blog);
  }

  @override
  Future<List<Blog>> getAllUserBlog(userid) {
    return BlogRemoteDataSource().getAllUserBlog(userid);
  }

  @override
  Future<int> editBlog(File? file, Blog updatedBlog, Blog blog, userId) {
    return BlogRemoteDataSource().editBlog(file, updatedBlog, blog, userId);
  }

  @override
  Future<int> deleteBlog(Blog blog, userId) {
    return BlogRemoteDataSource().deleteBlog(blog, userId);
  }
}
