import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news/model/Content.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

const maxOffset = 100;

class Page extends State<FindPage> {
  double appBarAlpha = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              //状态监听
              onNotification: (notification) {
                //如果是滚动更新通知的值并且深度限制为0[就是监听ListView]
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  //如果是
                  _onScrol(notification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562324532571&di=80a74e17231e47372ad4cacda1926230&imgtype=0&src=http%3A%2F%2Fphotos.tuchong.com%2F414540%2Ff%2F27530238.jpg',
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 800,
                    child: Text(
                      '渐变appBar',
                      style: Theme.of(context).textTheme.display2,
                    ),
                  )
                ],
              ),
            )),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 70,
            child: AppBar(
              title: Text('发现'),
              centerTitle: true,
            ),
          ),
        )
      ],
    ));
  }

  void _onScrol(offset) {
    double alpha = offset / maxOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future getData() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("https://news-at.zhihu.com/api/4/news/latest");
    print(response.data.toString());
  }
}

Widget layout(BuildContext context) {}
