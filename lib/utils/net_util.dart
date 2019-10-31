import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/dio.dart';
import 'package:news/config/manger.dart';

class NetUtil {
  Dio dio;
  static NetUtil instance;
  static NetUtil getInstance() {
    if (instance == null) {
      instance = new NetUtil();
    }
    return instance;
  }

  NetUtil() {
    dio = new Dio();
    //cookie持久化
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: AppManger.temporaryDirectory.path)));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
      return requestOptions;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError dioError) {
      return dioError;
    }));
  }
}
