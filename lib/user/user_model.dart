
import 'package:flutter/cupertino.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/user_entity.dart';

class UserModel extends ChangeNotifier{
  static const String kUser = 'kUser';


  UserEntity _userEntity;

  UserEntity get userEntity => _userEntity;

  bool get hasUserEntity => userEntity != null;

  UserModel() {
    var userMap = AppManger.localStorage.getItem(kUser);
    _userEntity = userMap != null ?UserEntity.fromJson(userMap) : null;
  }

  saveUser(UserEntity userEntity){
    _userEntity=userEntity;
    notifyListeners();
    AppManger.localStorage.setItem(kUser, userEntity);

  }


  /// 清除持久化的用户数据
  clearUser() {
    _userEntity = null;
    notifyListeners();
    AppManger.localStorage.deleteItem(kUser);
  }




}