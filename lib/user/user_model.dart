
import 'package:flutter/cupertino.dart';
import 'package:news/config/manger.dart';
import 'package:news/model/user_entity.dart';

class UserModel extends ChangeNotifier{
  static const String kUser = 'kUser';


  UserEntity userEntity;

  UserEntity get user => userEntity;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = AppManger.localStorage.getItem(kUser);
    userEntity = userMap != null ?UserEntity.fromJson(userMap) : null;
  }

  saveUser(UserEntity userEntity){
    userEntity=userEntity;
    notifyListeners();
    AppManger.localStorage.setItem(kUser, user);

  }


  /// 清除持久化的用户数据
  clearUser() {
    userEntity = null;
    notifyListeners();
    AppManger.localStorage.deleteItem(kUser);
  }


}