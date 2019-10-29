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
    return response;
  }

  /// 注册
  static Future register(String username, String password,String rePass) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(Api.REGISTER_URL, queryParameters: {
      "username": username,
      "password": password,
      "repassword": rePass
    });
    return response;
  }

  static Future logout()async{
    Dio dio = Dio();
    var response = await dio.get(Api.LOGIN_OUT_URL);
    return UserEntity.fromJson(response.data);
  }

}
