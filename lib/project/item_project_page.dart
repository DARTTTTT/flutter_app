import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/home/ItemDetail.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/Content.dart';
import 'package:news/model/article_entity.dart';
import 'package:news/model/banner_entity.dart';

class ProjectItemPage extends StatefulWidget {
  int id;

  String url;

  ProjectItemPage(this.url,this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

const maxOffset = 100;

class Page extends State<ProjectItemPage> with AutomaticKeepAliveClientMixin {
  var _items_banner = [];
  var _items_article = [];

  ScrollController scrollController = new ScrollController();
  int count = 0;
  bool isPerformingRequest = false;

  double appBarAlpha = 0;

  @override
  void initState() {
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
          scrollController.position.minScrollExtent) {

      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    await getData();
    await getArticleData(1);
    return;
  }

  Widget layout(BuildContext context) {
    Widget childWidget;
    if (_items_article.length != 0) {
      childWidget = new Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.red,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(_buildListItem,
                        childCount: _items_article.length),
                    itemExtent: 120.0,
                  ),
                ],
                controller: scrollController,
              ),
            ),
            // )
          ),
        ],
      );
    } else {
      childWidget = Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle(
              color: Colors.red,
              size: 30.0,
            ),
            new Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "正在加载",
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            )
          ],
        ),
      );
    }
    return childWidget;
  }

  Widget _buildListItem(BuildContext context, int index) {
    Widget childWidget;
    ArticleModel articleModel = this._items_article[index];
    if (index == _items_article.length - 1) {
      //下拉加载的视图
      return _buildProgressIndicator();
    } else {
      if (articleModel.articleDataData.envelopePic != "") {
        childWidget = GestureDetector(
          onTap: () {
            //页面详情跳转
            Navigator.push(context, new CupertinoPageRoute(builder: (context) => ItemInfoDetail(
                          url: articleModel.articleDataData.link,
                          title: articleModel.articleDataData.title,
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
                            articleModel.articleDataData.shareUser,
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black45),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 8,
                          child: Text(
                            articleModel.articleDataData.niceDate,
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
                            articleModel.articleDataData.envelopePic,
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
                                articleModel.articleDataData.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: Content.TEXT_CONTENT_SIZE, color: Colors.black),
                              ),
                              new Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                articleModel.articleDataData.desc,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: Content.TEXT_CONTENT_SECOND_SIZE, color: Colors.black45),
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
                        new Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          articleModel.articleDataData.superChapterName +
                              "·" +
                              articleModel.articleDataData.chapterName,
                          style: TextStyle(fontSize: 11.0),
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
                          url: articleModel.articleDataData.link,
                          title: articleModel.articleDataData.title,
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
                            articleModel.articleDataData.shareUser,
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black45),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 8,
                          child: Text(
                            articleModel.articleDataData.niceDate,
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
                            articleModel.articleDataData.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                                TextStyle(fontSize: Content.TEXT_CONTENT_SIZE, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    flex: 2,
                  ),
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          articleModel.articleDataData.superChapterName +
                              "·" +
                              articleModel.articleDataData.chapterName,
                          style: TextStyle(fontSize: 11.0),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return layout(context);
  }

  Future getData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.BANNER_URL);
    Map data = response.data;
    BannerEntity bannerEntity = BannerEntity.fromJson(data);
    var items = [];
    List<BannerData> _picList = bannerEntity.data;
    //遍历添加到数组当中去
    _picList.forEach((item) {
      items.add(ImagesModel(item));
    });

    setState(() {
      _items_banner = items;
    });
  }

  Future getArticleData(int count) async {
    Response response;
    Dio dio = Dio();
    String url = widget.url + count.toString() + "/json";
    print(url);
    print(widget.id);
    response = await dio.get(url, queryParameters: {"cid": widget.id});
    Map aritcle_data = response.data;
    ArticleEntity articleEntity = ArticleEntity.fromJson(aritcle_data);
    var article_items = [];
    List<ArticleDataData> _articleList = articleEntity.data.datas;
    _articleList.forEach((item) {
      article_items.add(ArticleModel(item));
    });

    print(aritcle_data);
    setState(() {
      _items_article = article_items;
    });
  }

  Future getMoreArticleData(int count) async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      Response response;
      Dio dio = Dio();
      String url = widget.url + count.toString() + "/json";
      response = await dio.get(url, queryParameters: {"cid": widget.id});

      Map aritcle_data = response.data;
      ArticleEntity articleEntity = ArticleEntity.fromJson(aritcle_data);
      var article_items = [];
      List<ArticleDataData> _articleList = articleEntity.data.datas;
      _articleList.forEach((item) {
        article_items.add(ArticleModel(item));
      });
      print(aritcle_data);
      setState(() {
        _items_article.addAll(article_items);
        isPerformingRequest = false;
      });
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ImagesModel {
  BannerData bannerData;

  ImagesModel(this.bannerData);
}

class ArticleModel {
  ArticleDataData articleDataData;

  ArticleModel(this.articleDataData);
}
