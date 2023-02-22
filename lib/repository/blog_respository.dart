import 'dart:io';

import 'package:blogit/data_source/remote_data_source/blog_data_source.dart';
import 'package:blogit/model/blog.dart';

abstract class BlogRepository {
  Future<List<Blog>> getAllBlog();
  Future<Blog?> getABlog(id);
  Future<int> createBlog(File? file, Blog blog);
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
}
