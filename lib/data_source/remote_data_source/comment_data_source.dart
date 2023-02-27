import 'package:blogit/app/constants.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/comment.dart';
import 'package:dio/dio.dart';

class CommentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> createComment(String blogId, Comment comment) async {
    try {
      FormData formData = FormData.fromMap({
        'body': comment.body,
      });
      _httpServices.options.headers["Authorization"] = Constant.token;

      Response response = await _httpServices.post(
        '${Constant.blogURL}/$blogId/comments',
        data: formData,
      );
      print("API endpoint: ${Constant.blogURL}/$blogId/comments");
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");

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
}
