import 'package:blogit/app/constants.dart';
import 'package:blogit/data_source/remote_data_source/response/login_respinse.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/user.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(User user) async {
    try {
      FormData formData = FormData.fromMap({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      });

      Response response = await _httpServices.post(
        Constant.userURL,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
