import 'package:blogit/app/constants.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/comment.dart';
import 'package:dio/dio.dart';

class CommentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> createComment(String blogId, String comment) async {
    try {
      FormData formData = FormData.fromMap({
        'body': comment,
      });
      print('Form Data is ${formData}');
      _httpServices.options.headers["Authorization"] = Constant.token;

      Response response = await _httpServices.post(
        '${Constant.blogURL}/$blogId/${Constant.commentURL}',
        data: {'body': comment},
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to create comment');
    }
  }

  Future<List<Comment>> getAllComment(String blogId) async {
    try {
      final response = await _httpServices
          .get('${Constant.blogURL}/$blogId/${Constant.commentURL}');
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> commentDataList =
            List<Map<String, dynamic>>.from(response.data);
        print("blogDataList: $commentDataList");
        final List<Comment> comments = commentDataList
            .map((blogData) => Comment.fromJson(blogData))
            .toList();
        return comments;
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load comments');
    }
  }
}
