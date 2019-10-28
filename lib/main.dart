import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/config/manger.dart';
import 'package:news/manger/provider_manager.dart' as prefix0;
import 'package:news/model/login_model.dart';
import 'package:news/user/user_model.dart';
import 'package:provider/provider.dart';

import 'index/Index.dart';
import 'manger/provider_manager.dart';
export 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  await AppManger.init();
  runApp(MyApp());
//沉浸式状态栏
  /* if(Platform.isAndroid){
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }*/
  // Android状态栏透明
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(

      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Index(),
      ),
    );
  }
}
