import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/user_entity.dart';

class UserModel extends ChangeNotifier {
  UserEntity _userEntity;

  UserEntity get userEntity => _userEntity;

  bool get hasUserEntity => userEntity != null;

  UserModel() {
    var userMap = AppManger.sharedPreferences.getString(Content.KEY_USER);
    if (userMap != null) {
      Map<String, dynamic> map = json.decode(userMap);
      debugPrint("用户返回:" + userMap.toString());
      _userEntity = UserEntity.fromJson(map);
    } else {
      _userEntity = null;
    }
  }

  saveUser(var jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    _userEntity = UserEntity.fromJson(map);
    print("登录:"+_userEntity.data.nickname);
    notifyListeners();
    AppManger.sharedPreferences.setString(Content.KEY_USER, jsonData);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _userEntity = null;
    notifyListeners();
    AppManger.sharedPreferences.remove(Content.KEY_USER);
    AppManger.sharedPreferences.remove(Content.KEY_USER_NAME);
  }
}
