import 'package:dio/dio.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/user_entity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class AppRepository {
  /// 登录
  static Future login(String username, String password) async {
    var cookieJar=CookieJar();
    Dio dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    var response = await dio.post(Api.LOGIN_URL, queryParameters: {
      "username": username,
      "password": password,
    });
    return response;
  }

  /// 注册
  static Future register(String username, String password,String rePass) async {
    var cookieJar=CookieJar();
    Response response;
    Dio dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
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
