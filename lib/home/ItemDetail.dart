import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news/entity/Content.dart';
import 'package:news/model/login_model.dart';
import 'package:news/user/like_model.dart';

import '../main.dart';

class ItemInfoDetail extends StatefulWidget {
  bool isLike;
  String url;
  String title;
  bool collect;
  int id;
  int originId;

  ItemInfoDetail(
      {this.isLike,
      this.url,
      this.title,
      this.collect,
      this.id,
      this.originId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoDetail(
        isLike: isLike,
        url: url,
        title: title,
        collect: collect,
        id: id,
        originId: originId);
  }
}

class InfoDetail extends State<ItemInfoDetail> {
  bool isLike;
  String url;
  String title;
  bool collect;
  int id;
  int originId;

  InfoDetail(
      {this.isLike,
      this.url,
      this.title,
      this.collect,
      this.id,
      this.originId});

  @override
  Widget build(BuildContext context) {
    var likeModel = Provider.of<LikeModel>(context);
    var model = Provider.of<LoginModel>(context);
    var color=  Theme.of(context).primaryColor;

    return Stack(
      children: <Widget>[
        WebviewScaffold(
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: color,
              title: Text(
                title,
                style: TextStyle(fontSize: Content.TEXT_TITLE_SIZE),
              ),
              actions: <Widget>[
                IconButton(
                  icon: collect
                      ? Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    if (collect) {
                      likeModel.removeLike(id);
                      print(isLike);
                      if (isLike) {
                        model.uncollectLike(id.toString(),originId.toString());
                      } else {
                        model.uncollect(id.toString());
                      }
                    } else {
                      likeModel.addLike(id);
                      model.collect(id.toString());
                    }
                    //关键代码
                    collect = !(collect ?? true);
                  },
                ),
              ],
            ),
            preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
          ),
          url: url,
          withJavascript: true,
          withLocalStorage: true,
          withZoom: false,
        ),
      ],
    );
    // TODO: implement build
  }
}
