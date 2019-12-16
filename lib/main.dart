import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/config/manger.dart';
import 'package:news/model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'index/Index.dart';
import 'manger/provider_manager.dart';

export 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await AppManger.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OKToast(
        child: MultiProvider(
      //数据管理
      providers: providers,
      child: Consumer<ThemeModel>(builder: (context, model, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
              backgroundColor: Colors.transparent,
              primaryColor: model.themeColor,
              accentColor: model.themeColor,
              indicatorColor: Colors.white),
          home: new Index(),
        );
      }),
    ));
  }
}
