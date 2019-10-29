import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news/config/manger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'index/Index.dart';
import 'manger/provider_manager.dart';

export 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  await AppManger.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OKToast(child: MultiProvider(

      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Index(),
      ),
    ));

  }
}
