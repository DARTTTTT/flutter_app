import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/banner_entity.dart';
import 'package:news/model/article_entity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ItemInfoDetail.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<HomePage> with AutomaticKeepAliveClientMixin {
  var _items_banner = [];
  var _items_article = [];
  ScrollController scrollController = new ScrollController();
  int count = 0;
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    getData();
    getArticleData(0);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        count++;
        getMoreArticleData(count);
      }
    });
  }

  Future<Null> _refresh() async {
    await getData();
    await getArticleData(0);
    return;
  }

  Widget layout(BuildContext context) {
    Widget childWidget;
    if (_items_article.length != 0) {
      childWidget = new Scaffold(
          body: RefreshIndicator(
            onRefresh: _refresh,
            color: Colors.red,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: BannerView(),
                ),

                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      _buildListItem,
                      childCount: _items_article.length),
                  itemExtent: 80.0,
                ),

              ],
              controller: scrollController,
            ),
          ));
    } else {
      childWidget = new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在加载'),
            ),
          ),
        ],
      );
    }
    return childWidget;
  }

  Widget _buildListItem(BuildContext context, int index) {
    Widget childWidget;
    ArticleModel articleModel = this._items_article[index];
    if (index == _items_article.length - 1) {
      return _buildProgressIndicator();
    } else {


      if (articleModel.articleDataData.envelopePic != "") {
        childWidget = GestureDetector(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                ItemInfoDetail(url: articleModel.articleDataData.link,
                  title: articleModel.articleDataData.title,)));
          },
          child: Center(
            child: new Container(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            padding: const EdgeInsets.fromLTRB(
                                3.0, 6.0, 3.0, 0.0),
                            child: new Image.network(
                              articleModel.articleDataData.envelopePic,
                              fit: BoxFit.cover,
                            ),
                            height: 80,
                            width: 80,
                          ),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new Text(articleModel.articleDataData.title),
                          flex: 2,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      } else {
        childWidget = GestureDetector(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                ItemInfoDetail(url: articleModel.articleDataData.link,
                  title: articleModel.articleDataData.title,)));
          },
          child: Center(
            child: new Container(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Text(articleModel.articleDataData.title),
                          flex: 2,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      }
    }

    return childWidget;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(3.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(
          ),
        ),
      ),
    );
  }

  //轮播图
  Widget BannerView() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 200.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          ImagesModel im = this._items_banner[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemInfoDetail(
                            url: im.bannerData.url,
                            title: im.bannerData.title,
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
              activeColor: Colors.red,
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
    String url = Api.ARTICLE_LIST_URL + count.toString() + "/json";
    print(url);

    response = await dio.get(url);
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
      String url = Api.ARTICLE_LIST_URL + count.toString() + "/json";
      print(url);

      response = await dio.get(url);
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
