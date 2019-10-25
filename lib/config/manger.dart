
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class AppManger{
  /// app全局配置 eg:theme
  static SharedPreferences sharedPreferences;

  static LocalStorage localStorage;

  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}