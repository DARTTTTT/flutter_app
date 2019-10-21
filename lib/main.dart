import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'index/Index.dart';

void main() async {
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

    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      home: new Index(),

    );
  }


}














