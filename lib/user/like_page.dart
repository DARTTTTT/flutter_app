import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/like_entity.dart';
import 'package:news/home/ItemDetail.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:news/view/login_widget.dart';

class LikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<LikePage> {
  int count = 0;

  LikeEntity _likeEntity;

  bool isPerformingRequest = false;

  bool isShow=false;

  ScrollController scrollController = new ScrollController();

  Future<Null> _refresh() async {
    // await getData();
    await getArticleData(0);

    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    getArticleData(0);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        count++;
        //上拉加载更多
        getMoreArticleData(count);
      }

      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {}
    });
  }

  @override
  Widget build(BuildContext context) {

  print(isShow);

    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            "我的收藏",
            style: TextStyle(
                fontSize: Content.TEXT_TITLE_SIZE, color: Colors.white),
          ),
        ),
        preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
      ),
      body: new Stack(
        children:<Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: !isShow?DialogProgressIndicator("正在加载"):RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.red,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(_buildListItem,
                        childCount: _likeEntity.data.datas.length),
                    itemExtent: 120.0,
                  ),
                ],
                controller: scrollController,
              ),
            ),
            // )
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Widget childWidget;

    if (index == _likeEntity.data.datas.length - 1) {
      //下拉加载的视图
      return _buildProgressIndicator();
    } else {
      if (_likeEntity.data.datas[index].envelopePic != "") {
        childWidget = GestureDetector(
          onTap: () {
            //页面详情跳转
            Navigator.push(
                context,
                new CupertinoPageRoute(
                    builder: (context) => ItemInfoDetail(
                          url: _likeEntity.data.datas[index].link,
                          title: _likeEntity.data.datas[index].title,
                        )));
          },
          child: new Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid,
                        color: Colors.grey[200])),
              ),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 15,
                          top: 8,
                          child: Text(
                            _likeEntity.data.datas[index].author,
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black45),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 8,
                          child: Text(
                            _likeEntity.data.datas[index].niceDate,
                            style: TextStyle(
                                fontSize: 11.0, color: Colors.black45),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Stack(
                      children: <Widget>[
                        Positioned(
                          left: 15,
                          child: Image.network(
                            _likeEntity.data.datas[index].envelopePic,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 50,
                          ),
                        ),
                        Positioned(
                          right: 15,
                          left: 85,
                          child: new Column(
                            children: <Widget>[
                              Text(
                                _likeEntity.data.datas[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: Content.TEXT_CONTENT_SIZE,
                                    color: Colors.black),
                              ),
                              new Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                _likeEntity.data.datas[index].desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: Content.TEXT_CONTENT_SECOND_SIZE,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Container(
                            child: Text(
                              _likeEntity.data.datas[index].chapterName,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border:
                                new Border.all(color: Colors.red, width: 0.5),
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(3.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Container(
                            child: Text(
                              _likeEntity.data.datas[index].chapterName,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border:
                                new Border.all(color: Colors.red, width: 0.5),
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(3.0),
                          ),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              )),
        );
      } else {
        childWidget = GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new CupertinoPageRoute(
                    builder: (context) => ItemInfoDetail(
                          url: _likeEntity.data.datas[index].link,
                          title: _likeEntity.data.datas[index].title,
                        )));
          },
          child: new Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid,
                        color: Colors.grey[200])),
              ),
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 15,
                          top: 8,
                          child: Text(
                            _likeEntity.data.datas[index].author,
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black45),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 8,
                          child: Text(
                            _likeEntity.data.datas[index].niceDate,
                            style: TextStyle(
                                fontSize: 11.0, color: Colors.black45),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Stack(
                      children: <Widget>[
                        Positioned(
                          left: 15,
                          right: 15,
                          top: 5,
                          child: Text(
                            _likeEntity.data.datas[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: Content.TEXT_CONTENT_SIZE,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Container(
                            child: Text(
                              _likeEntity.data.datas[index].chapterName,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border:
                                new Border.all(color: Colors.red, width: 0.5),
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(3.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Container(
                            child: Text(
                              _likeEntity.data.datas[index].chapterName,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          /* decoration: BoxDecoration(
                            border:
                            new Border.all(color: Colors.red, width: 0.5),
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(3.0),
                          ),*/
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              )),
        );
      }
    }

    return childWidget;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(0.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCircle(
                color: Colors.red,
                size: 30.0,
              ),
              new Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                "正在加载",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getArticleData(int count) async {

    Response response;
    Dio dio = Dio();
    var cookieJar=CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    String url = Api.LIKE_URL + count.toString() + "/json";
    print(url);
    response = await dio.get(url);
    Map aritcle_data = response.data;
    debugPrint("返回的数据: " + response.data.toString());
    LikeEntity likeEntity = LikeEntity.fromJson(aritcle_data);
    setState(() {
      _likeEntity = likeEntity;
      if( _likeEntity.data!=null){
        isShow=true;
      }else{
        isShow=false;
      }
    });
  }

  Future getMoreArticleData(int count) async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      Response response;
      Dio dio = Dio();
      var cookieJar=CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      String url = Api.LIKE_URL + count.toString() + "/json";
      response = await dio.get(url);

      Map aritcle_data = response.data;
      LikeEntity likeEntity = LikeEntity.fromJson(aritcle_data);
      setState(() {
        _likeEntity = likeEntity;
        isPerformingRequest = false;
      });
    }
  }
}
