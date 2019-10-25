

import 'package:flutter/cupertino.dart';
import 'package:news/base/app_repository.dart';
import 'package:news/config/manger.dart';
import 'package:news/user/user_model.dart';

class LoginModel extends ChangeNotifier{
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  Future<bool> login(loginName, password) async {
   
  }

}