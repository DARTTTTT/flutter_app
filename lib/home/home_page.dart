import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/banner_entity.dart';
import 'package:news/home/search_page.dart';
import 'package:news/main.dart';
import 'package:news/model/login_model.dart';
import 'package:news/user/like_model.dart';
import 'package:news/utils/net_util.dart';

import 'ItemDetail.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

const maxOffset = 100;

class Page extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  var _items_banner = [];
  var _items_article = [];

  ScrollController scrollController = new ScrollController();
  int count = 0;
  bool isPerformingRequest = false;
  double appBarAlpha = 0;
  double floatAlpha = 1;
  bool itemType = true;
  List<ArticleDataData> articleDataList;
  var color;
  @override
  void initState() {
    super.initState();



    getData();
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    await getData();
    await getArticleData(0);
    return;
  }

  Widget layout(BuildContext context) {
    Widget childWidget;
     color=  Theme.of(context).primaryColor;

    if (_items_article.length != 0) {
      childWidget = new Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  _onScrol(notification.metrics.pixels);
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: color,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: new Container(
                        child: BannerView(),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 8,
                                  style: BorderStyle.solid,
                                  color: Colors.grey[200])),
                        ),
                      ),
                    ),
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(_buildListItem,
                          childCount: _items_article.length),
                      itemExtent: 120.0,
                    ),
                  ],
                  controller: scrollController,
                ),
              ),
            ),

            // )
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: MediaQuery.of(context).padding.top + Content.BAR_HEIGHT,
              child: AppBar(
                backgroundColor: color,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (appBarAlpha == 1) {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => SearchPage()));
                      }
                    },
                  ),
                ],
                title: Text(
                  "玩安卓",
                  style: TextStyle(
                      fontSize: Content.TEXT_TITLE_SIZE, color: Colors.white),
                ),
                //centerTitle: true,
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 20,
            child: Opacity(
                opacity: floatAlpha,
                child: Container(
                    height: 48,
                    child: FloatingActionButton(
                      backgroundColor: color,
                      child: new Icon(Icons.search),
                      onPressed: () {
                        if (floatAlpha == 1) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                        }
                      },
                    ))),
          )
        ],
      );
    } else {
      childWidget = Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle(
              color:color,
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

    var model = Provider.of<LoginModel>(context);

    var likeModel = Provider.of<LikeModel>(context);

    if (articleModel.articleDataData.envelopePic != "") {
      itemType = true;
    } else {
      itemType = false;
    }
    if (index == _items_article.length - 1) {
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
                        isLike: false,
                        url: articleModel.articleDataData.link,
                        title: articleModel.articleDataData.title,
                        collect: articleModel.articleDataData.collect,
                        id: articleModel.articleDataData.id,
                        originId: null,
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
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black45),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        child: Text(
                          articleModel.articleDataData.niceDate,
                          style:
                              TextStyle(fontSize: 11.0, color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  child: itemType
                      ? Stack(
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
                                    articleModel.articleDataData.title
                                        .replaceAll("<em", "")
                                        .replaceAll("class=", "")
                                        .replaceAll("highlight", "")
                                        .replaceAll("'", "")
                                        .replaceAll(">", "")
                                        .replaceAll("</em", "")
                                        .replaceAll("&", "")
                                        .trim(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: Content.TEXT_CONTENT_SIZE,
                                        color: Colors.black),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                  Text(
                                    articleModel.articleDataData.desc,
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
                      : Stack(
                          children: <Widget>[
                            Positioned(
                              left: 15,
                              right: 15,
                              top: 5,
                              child: Text(
                                articleModel.articleDataData.title
                                    .replaceAll("<em", "")
                                    .replaceAll("class=", "")
                                    .replaceAll("highlight", "")
                                    .replaceAll("'", "")
                                    .replaceAll(">", "")
                                    .replaceAll("</em", "")
                                    .replaceAll("&", "")
                                    .trim(),
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
                  child: new Stack(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Text(
                                  articleModel.articleDataData.superChapterName,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: new Border.all(
                                    color: color, width: 0.5),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(3.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                child: Text(
                                  articleModel.articleDataData.chapterName,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: new Border.all(
                                    color: color, width: 0.5),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(3.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 15,
                          child: InkWell(
                            child: articleModel.articleDataData.collect
                                ? Icon(
                                    Icons.favorite,
                                    color: color,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: color,
                                  ),
                            onTap: () {
                              if (articleModel.articleDataData.collect) {
                                likeModel.removeLike(
                                    articleModel.articleDataData.id);
                                model.uncollect(
                                    articleModel.articleDataData.id.toString());
                              } else {
                                likeModel
                                    .addLike(articleModel.articleDataData.id);
                                model.collect(
                                    articleModel.articleDataData.id.toString());
                              }
                              //关键代码
                              articleModel.articleDataData.collect =
                                  !(articleModel.articleDataData.collect ??
                                      true);
                            },
                          )),
                    ],
                  ),
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
                color: color,
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

  //轮播图
  Widget BannerView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          ImagesModel im = this._items_banner[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ItemInfoDetail(
                            isLike: false,
                            url: im.bannerData.url,
                            title: im.bannerData.title,
                            collect: false,
                            id: im.bannerData.id,
                            originId: null,
                          )));
            },
            child: Image.network(
              im.bannerData.imagePath,
              fit: BoxFit.fill,
            ),
          );
          /*  return (Image.network(
            im.bannerData.imagePath,
            fit: BoxFit.fill,
          ));*/
        },
        itemCount: _items_banner.length,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          color: Colors.grey,
          activeColor:color,
          size: 6.0,
          activeSize: 6.0,
        )),
        control: null,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print("点击了$index"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return layout(context);
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
      floatAlpha = 1 - alpha;
    });
  }

  Future getData() async {

    Response response;
    response = await NetUtil().dio.get(Api.BANNER_URL);
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
    String url = Api.ARTICLE_LIST_URL + count.toString() + "/json";
    response = await NetUtil().dio.get(url);
    Map aritcle_data = response.data;
    ArticleEntity articleEntity = ArticleEntity.fromJson(aritcle_data);
    var article_items = [];
    List<ArticleDataData> _articleList = articleEntity.data.datas;
    _articleList.forEach((item) {
      article_items.add(ArticleModel(item));
    });

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
      String url = Api.ARTICLE_LIST_URL + count.toString() + "/json";

      response = await NetUtil().dio.get(url);
      Map aritcle_data = response.data;
      ArticleEntity articleEntity = ArticleEntity.fromJson(aritcle_data);
      var article_items = [];
      List<ArticleDataData> _articleList = articleEntity.data.datas;
      _articleList.forEach((item) {
        article_items.add(ArticleModel(item));
      });
      setState(() {
        _items_article.addAll(article_items);
        isPerformingRequest = false;
      });
    }
  }


}

class ImagesModel {
  BannerData bannerData;

  ImagesModel(this.bannerData);
}

class ArticleModel {
  ArticleDataData articleDataData;

  ArticleModel(this.articleDataData);
}
