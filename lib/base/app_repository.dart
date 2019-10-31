import 'package:news/entity/Api.dart';
import 'package:news/entity/user_entity.dart';
import 'package:news/utils/net_util.dart';

class AppRepository {
  /// 登录
  static Future login(String username, String password) async {
    var response =await NetUtil().dio.post(Api.LOGIN_URL, queryParameters: {
      "username": username,
      "password": password,
    });
    return response;
  }

  /// 注册
  static Future register(
      String username, String password, String rePass) async {
    var response = await NetUtil().dio.post(Api.REGISTER_URL, queryParameters: {
      "username": username,
      "password": password,
      "repassword": rePass
    });
    return response;
  }

  static Future logout() async {
    var response = await NetUtil().dio.get(Api.LOGIN_OUT_URL);
    return UserEntity.fromJson(response.data);
  }
  
  
  static Future collect(String id) async{
    String url=Api.COLLECT_URL+id+"/json";
    var response=await NetUtil().dio.post(url);
    return response;
  }

  static Future uncollect(String id) async{
    String url=Api.UN_COLLECT_URL+id+"/json";
    var response=await NetUtil().dio.post(url);
    return response;
  }
}
