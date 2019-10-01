import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<FindPage> {
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
    Dio dio = new Dio();
    response = await dio.get("https://news-at.zhihu.com/api/4/news/latest");

    print(response.data.toString());
  }
}

Widget layout(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: const Text("发现"),
    ),
    //body: ListView.builder(itemCount: _items.length, itemBuilder: itemView),
  );
}

Widget itemView(BuildContext context, int index) {}
