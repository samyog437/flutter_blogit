class LoginResponse {
  bool? success;
  String? message;
  String? token;
  String? userId;

  LoginResponse({this.success, this.message, this.token, this.userId});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['userId'] = userId;
    return data;
  }
}
