

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/base/app_repository.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/Content.dart';
import 'package:news/model/view_state_model.dart';
import 'package:news/user/user_model.dart';


class LoginModel extends ViewStateModel{


  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  String getLoginName() {
    return AppManger.sharedPreferences.getString(Content.KEY_USER_NAME);
  }
  Future<bool> login(loginName, password) async {
    setBusy(true);
    try{
      Response response=await AppRepository.login(loginName, password);
      var jsonData = json.encode(response.data);
      userModel.saveUser(jsonData);
      setBusy(false);
      return true;
    }
    catch(e){
      debugPrint("测试: ");
      setBusy(false);
      return false;
    }



  }

  Future<bool> logout() async {
    if (!userModel.hasUserEntity) {
      //防止递归
      return false;
    }
    setBusy(true);
    try {
      await AppRepository.logout();
      userModel.clearUser();
      setBusy(false);
      return true;
    } catch (e) {
      setError(e is Error ? e.toString() : e.message);
      return false;
    }
  }

}