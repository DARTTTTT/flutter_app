import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/base/app_repository.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/register_entity.dart';
import 'package:news/entity/user_entity.dart';
import 'package:news/model/view_state_model.dart';


class LoginModel extends ViewStateModel {

  UserEntity _userEntity;

  UserEntity get userEntity => _userEntity;

  bool get hasUserEntity => userEntity != null;


  String getLoginName() {
    return AppManger.sharedPreferences.getString(Content.KEY_USER_NAME);
  }

  LoginModel() {
    var userMap = AppManger.sharedPreferences.getString(Content.KEY_USER);
    if (userMap != null) {
      Map<String, dynamic> map = json.decode(userMap);
      debugPrint("用户返回:" + userMap.toString());
      _userEntity = UserEntity.fromJson(map);
    } else {
      _userEntity = null;
    }
  }


  /// 清除持久化的用户数据
  clearUser() {
    _userEntity = null;
    notifyListeners();
    AppManger.sharedPreferences.remove(Content.KEY_USER);
    AppManger.sharedPreferences.remove(Content.KEY_USER_NAME);
  }

  //保存登录数据
  saveUser(var jsonData) {
    Map<String, dynamic> map = json.decode(jsonData);
    _userEntity = UserEntity.fromJson(map);
    print("登录:" + _userEntity.data.nickname);
    notifyListeners();
    AppManger.sharedPreferences.setString(Content.KEY_USER, jsonData);
  }

  //登录方法
  Future<bool> login(loginName, password) async {
    setBusy(true);
    try {
      Response response = await AppRepository.login(loginName, password);
      var jsonData = json.encode(response.data);
      UserEntity userEntity = UserEntity.fromJson(response.data);
      setBusy(false);
      if (userEntity.errorCode == 0) {
        debugPrint("登录成功:" + jsonData);
        saveUser(jsonData);
        return true;
      } else {
        return false;
      }
    }
    catch (e) {
      setBusy(false);
      return false;
    }
  }

  //注册方法
  Future<bool> register(loginName, password, rePass) async {
    setBusy(true);
    try{
      Response response = await AppRepository.register(loginName, password, rePass);
      RegisterEntity registerEntity=RegisterEntity.fromJson(response.data);
      setBusy(false);
      if(registerEntity.errorCode==0){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      setBusy(false);
      return false;
    }


  }


  //退出方法
  Future<bool> logout() async {
    if (!hasUserEntity) {
      //防止递归
      return false;
    }
    setBusy(true);
    try {
      await AppRepository.logout();
      clearUser();
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }

}