import 'package:blogit/app/constants.dart';
import 'package:blogit/data_source/remote_data_source/response/blog_response.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/blog.dart';
import 'package:dio/dio.dart';

class BlogRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Blog>> getAllBlog() async {
    try {
      Response response = await _httpServices.get(
        Constant.blogURL,
      );
      print("API endpoint: ${Constant.blogURL}");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      if (response.statusCode == 200) {
        List<dynamic> blogsJson = response.data;
        // BlogResponse blogResponse = BlogResponse.fromJson(response.data);
        List<Blog> blogs =
            blogsJson.map((blogsJson) => Blog.fromJson(blogsJson)).toList();
        return blogs;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load Blog');
    }
  }

  Future<Blog?> getABlog(int id) async {
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
        return blog;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load a Blog');
    }
  }
}
