import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_app/index/news_bean_entity.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<HomePage> {
  String dataStr = "";
  var _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return layout(context);
  }

  Future getData() async {
    Response response;
    Dio dio = Dio();

    response = await dio.get("https://news-at.zhihu.com/api/4/news/latest");


    var data = response.data.toString();
    print('返回数据: '+data);
    if (data != null) {
      Map body = json.decode(data.toString());
      print(body);
      NewsBeanEntity newsBeanEntity = NewsBeanEntity.fromJson(body);
      print(newsBeanEntity);
      // var newsBeanEntity = new  NewsBeanEntity.fromJson(newsMap);

    }
  }


}

Widget layout(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: const Text("主页"),
    ),
    //body: ListView.builder(itemCount: _items.length, itemBuilder: itemView),
  );
}

Widget itemView(BuildContext context, int index) {}
