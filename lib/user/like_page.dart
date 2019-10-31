import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/like_entity.dart';
import 'package:news/home/ItemDetail.dart';
import 'package:news/main.dart';
import 'package:news/model/login_model.dart';
import 'package:news/utils/net_util.dart';
import 'package:news/view/login_widget.dart';

import 'login_page.dart';

class LikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<LikePage> {
  int count = 0;

  List<LikeDataData> _likeDataData;

  bool isPerformingRequest = false;

  bool isShow = false;

  bool itemType = true;

  bool isChartNameSHow=false;



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
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: !isShow
                ? DialogProgressIndicator("正在加载")
                : RefreshIndicator(
                    onRefresh: _refresh,
                    color: Colors.red,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverFixedExtentList(
                          delegate: SliverChildBuilderDelegate(_buildListItem,
                              childCount: _likeDataData.length),
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
    if (_likeDataData[index].envelopePic != "") {
      itemType = true;
    } else {
      itemType = false;
    }

    if(_likeDataData[index].chapterName!=""){
      isChartNameSHow=true;
    }else{
      isChartNameSHow=false;
    }


    if (index == _likeDataData.length - 1) {
      //下拉加载的视图
      return _buildProgressIndicator();
    } else {
      childWidget = GestureDetector(
        onTap: () {
          //页面详情跳转
          Navigator.push(
              context,
              new CupertinoPageRoute(
                  builder: (context) => ItemInfoDetail(
                        url: _likeDataData[index].link,
                        title: _likeDataData[index].title,
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
                          _likeDataData[index].author,
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black45),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        child: Text(
                          _likeDataData[index].niceDate,
                          style:
                              TextStyle(fontSize: 11.0, color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  child: itemType
                      ? new Stack(
                          children: <Widget>[
                            Positioned(
                              left: 15,
                              child: Image.network(
                                _likeDataData[index].envelopePic,
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
                                    _likeDataData[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: Content.TEXT_CONTENT_SIZE,
                                        color: Colors.black),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                  Text(
                                    _likeDataData[index].desc,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize:
                                            Content.TEXT_CONTENT_SECOND_SIZE,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : new Stack(
                          children: <Widget>[
                            Positioned(
                              left: 15,
                              right: 15,
                              top: 5,
                              child: Text(
                                _likeDataData[index].title,
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
                  child: isChartNameSHow?new Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Container(
                          child: Text(
                            _likeDataData[index].chapterName,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.red, width: 0.5),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(3.0),
                        ),
                      ),

                    ],
                  ):Row(),
                  flex: 1,
                ),
              ],
            )),
      );
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

    String url = Api.LIKE_URL + count.toString() + "/json";
    print(url);
    response = await NetUtil().dio.get(url);
    Map aritcle_data = response.data;
    debugPrint("返回的数据: " + response.data.toString());
    LikeEntity likeEntity = LikeEntity.fromJson(aritcle_data);
    if(likeEntity.errorCode==-1001){
      var model=Provider.of<LoginModel>(context);
      model.clearUser();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => LoginPage()));
      return;
    }
    List<LikeDataData> _data = likeEntity.data.datas;

    setState(() {
      _likeDataData = _data;

      if (_likeDataData != null) {
        isShow = true;
      } else {
        isShow = false;
      }
    });
  }

  Future getMoreArticleData(int count) async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      Response response;

      String url = Api.LIKE_URL + count.toString() + "/json";
      response = await NetUtil().dio.get(url);
      LikeEntity likeEntity = LikeEntity.fromJson(response.data);

      List<LikeDataData> _data = likeEntity.data.datas;

      setState(() {
        _likeDataData.addAll(_data);
        isPerformingRequest = false;
      });
    }
  }
}


