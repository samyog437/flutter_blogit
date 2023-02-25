import 'dart:convert';
import 'dart:io';

import 'package:blogit/app/constants.dart';
import 'package:blogit/data_source/remote_data_source/response/blog_response.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/blog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class BlogRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  // Future<List<Blog>> getAllBlog() async {
  //   try {
  //     Response response = await _httpServices.get(
  //       Constant.blogURL,
  //     );
  //     print("API endpoint: ${Constant.blogURL}");
  //     print("Status code: ${response.statusCode}");
  //     print("Response data: ${response.data.runtimeType}: ${response.data}");
  //     if (response.statusCode == 200) {
  //       print("before blogsJson");

  //       List<dynamic> blogsJson = json.decode('${response.data}');
  //       print("blogsJson: $blogsJson");
  //       // BlogResponse blogResponse = BlogResponse.fromJson(response.data);

  //       List<Blog> blogs =
  //           blogsJson.map((blogsJson) => Blog.fromJson(blogsJson)).toList();

  //       return blogs;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     throw Exception('Failed to load Blog');
  //   }
  // }

  Future<List<Blog>> getAllBlog() async {
    try {
      final response = await _httpServices.get(Constant.blogURL);
      print("API endpoint: ${Constant.blogURL}");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> blogDataList =
            List<Map<String, dynamic>>.from(response.data);

        print("blogDataList: $blogDataList");

        final List<Blog> blogs =
            blogDataList.map((blogData) => Blog.fromJson(blogData)).toList();
        return blogs;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load Blog');
    }
  }

  Future<List<Blog>> getAllUserBlog(String userId) async {
    try {
      final response = await _httpServices.get(Constant.blogURL);
      print("API endpoint: ${Constant.blogURL}");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> blogDataList =
            List<Map<String, dynamic>>.from(response.data);
        print("blogDataList: $blogDataList");

        final List<Blog> blogs =
            blogDataList.map((blogData) => Blog.fromJson(blogData)).toList();
        return blogs.where((blog) => blog.users?.usrId == userId).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load Blog');
    }
  }

  Future<Blog?> getABlog(String id) async {
    try {
      Response response = await _httpServices.get(
        '${Constant.blogURL}/$id',
      );
      print("API endpoint: ${Constant.blogURL}/$id");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      if (response.statusCode == 200) {
        Map<String, dynamic> blogJson = response.data;
        Blog blog = Blog.fromJson(blogJson);
        print("Blog user: ${blog.user}");

        return blog;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load a Blog');
    }
  }

  Future<int> createBlog(File? file, Blog blog) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType('image', mimeType!.split("/")[1]),
        );
      }

      FormData formData = FormData.fromMap({
        'image': image,
        'title': blog.title,
        'content': blog.content,
      });

      _httpServices.options.headers["Authorization"] = Constant.token;

      Response response = await _httpServices.post(
        Constant.blogURL,
        data: formData,
      );
      print("API endpoint: ${Constant.blogURL}");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to create Blog');
      // return 0;
    }
  }
}
