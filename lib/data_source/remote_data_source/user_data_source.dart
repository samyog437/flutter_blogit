import 'dart:convert';

import 'package:blogit/app/constants.dart';
import 'package:blogit/data_source/remote_data_source/response/login_response.dart';
import 'package:blogit/data_source/remote_data_source/response/user_response.dart';
import 'package:blogit/helper/http_service.dart';
import 'package:blogit/model/user.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(User user) async {
    try {
      Map<String, dynamic> data = ({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      });

      Response response = await _httpServices.post(
        Constant.userURL,
        data: json.encode(user.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
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

  Future<int> updateUser(User user) async {
    try {
      Map<String, dynamic> data = ({
        'username': user.username,
        'email': user.email,
        'password': user.password,
      });
      _httpServices.options.headers["Authorization"] = Constant.token;
      Response response = await _httpServices.put(
        '${Constant.userURL}/${user.usrId!}',
        data: json.encode(data),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
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
        Constant.userId = loginResponse.userId!;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getUserData(String userId) async {
    try {
      _httpServices.options.headers["Authorization"] = Constant.token;

      final response = await _httpServices.get('${Constant.userURL}/$userId');
      // print("API endpoint: ${Constant.userURL}/$userId");
      // print("Status code: ${response.statusCode}");
      // print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        UserResponse userResponse = UserResponse.fromJson(response.data);
        return userResponse.data!;
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load user');
    }
  }
}
