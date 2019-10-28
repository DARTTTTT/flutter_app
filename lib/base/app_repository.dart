import 'package:dio/dio.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/user_entity.dart';

class AppRepository {
  /// 登录
  static Future login(String username, String password) async {
    Dio dio = Dio();
    var response = await dio.post(Api.LOGIN_URL, queryParameters: {
      "username": username,
      "password": password,
    });
    return UserEntity.fromJson(response.data);
  }

  static Future logout()async{
    Dio dio = Dio();
    var response = await dio.get(Api.LOGIN_OUT_URL);
    return UserEntity.fromJson(response.data);
  }

}
