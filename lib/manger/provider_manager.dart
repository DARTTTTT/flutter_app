import 'package:news/model/home_model.dart';
import 'package:news/model/login_model.dart';
import 'package:news/model/theme_model.dart';
import 'package:news/user/like_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<LoginModel>.value(value: LoginModel()),
  ChangeNotifierProvider<LikeModel>.value(value: LikeModel()),
  ChangeNotifierProvider<HomeModel>.value(value: HomeModel()),
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),

];




