import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news/model/Content.dart';

class ItemInfoDetail extends StatefulWidget {
  String url;
  String title;

  ItemInfoDetail({this.url, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoDetail(url: url, title: title);
  }
}

class InfoDetail extends State<ItemInfoDetail> {
  String url;
  String title;

  InfoDetail({this.url, this.title});

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
     return WebviewScaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.red,
            title: Text(title,style: TextStyle(fontSize: Content.TEXT_TITLE_SIZE),),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
        ),
        url: url,
        withJavascript: true,
        withLocalStorage: true,
        withZoom: false,
      );

  }
}