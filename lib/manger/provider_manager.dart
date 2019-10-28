import 'package:news/model/login_model.dart';
import 'package:news/user/user_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<UserModel>.value(value: UserModel()),
  ChangeNotifierProvider<LoginModel>.value(value: LoginModel(new UserModel())),

];




