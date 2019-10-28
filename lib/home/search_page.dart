import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/hotkey_entity.dart';

import 'ItemDetail.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<SearchPage> {
  HotkeyEntity hotkeyEntity = null;
  bool visible = false;
  bool visible_content = true;
  bool isPerformingRequest = false;
  var _items_article = [];
  ScrollController scrollController = new ScrollController();
  TextEditingController textEditingController = new TextEditingController();
  int count = 0;
  String search_content = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetHoteKey();
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
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.red,
            title: TextField(
              autofocus: false,
              textInputAction: TextInputAction.search,
              controller: textEditingController,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                hintText: "搜索你要的内容",
                fillColor: Colors.transparent,
                border: InputBorder.none,
                filled: true,
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
              ),
              //点击键盘的监听回调
              onSubmitted: (val) {
                visible = !visible;
                visible_content = !visible_content;
                getArticleData(0, textEditingController.text.toString());
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (textEditingController.text.length != 0) {
                      visible = !visible;
                      visible_content = !visible_content;
                      //防止输入没有搜索导致点击有问题
                      if (_items_article.length == 0) {
                        visible = false;
                        visible_content = true;
                      }
                      search_content = "";
                      _items_article.clear();
                      //下标从0开始
                      count = 0;
                      textEditingController.clear();
                    } else {
                      Navigator.pop(context);
                    }
                  });
                },
              )
            ],
          ),
          preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
        ),
        body: Stack(
          children: <Widget>[
            Offstage(
                offstage: visible,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: HotKeyWiget(),
                )),
            Offstage(offstage: visible_content, child: SearchWidget()),
          ],
          //显示隐藏
        ));
  }

  Widget SearchWidget() {
    Widget childWidget;
    if (_items_article.length == 0) {
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
    } else {
      childWidget = CustomScrollView(
        slivers: <Widget>[
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem,
                childCount: _items_article.length),
            itemExtent: 120.0,
          ),
        ],
        controller: scrollController,
      );
    }
    return childWidget;
  }

  //搜索列表
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
            Navigator.push(
                context,
                new CupertinoPageRoute(
                    builder: (context) => ItemInfoDetail(
                          url: articleModel.articleDataData.link,
                          title:   articleModel.articleDataData.title.replaceAll("<em", "").
                          replaceAll("class=", "").
                          replaceAll("highlight", "").replaceAll("'", "")
                              .replaceAll(">", "").replaceAll("</em", "").replaceAll("&", "").trim(),
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
                            articleModel.articleDataData.author,
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
                                articleModel.articleDataData.title.replaceAll("<em", "").
                                replaceAll("class=", "").
                                replaceAll("highlight", "").replaceAll("'", "")
                                    .replaceAll(">", "").replaceAll("</em", "").replaceAll("&", "").trim(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: Content.TEXT_CONTENT_SIZE,
                                    color: Colors.black),
                              ),
                              new Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                articleModel.articleDataData.desc,
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
                          title:   articleModel.articleDataData.title.replaceAll("<em", "").
                          replaceAll("class=", "").
                          replaceAll("highlight", "").replaceAll("'", "")
                              .replaceAll(">", "").replaceAll("</em", "").replaceAll("&", "").trim(),
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
                            articleModel.articleDataData.author,
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
                            articleModel.articleDataData.title.replaceAll("<em", "").
                            replaceAll("class=", "").
                            replaceAll("highlight", "").replaceAll("'", "")
                                .replaceAll(">", "").replaceAll("</em", "").replaceAll("&", "").trim(),
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

  //热门搜索
  Widget HotKeyWiget() {
    Widget childWidget;

    if (hotkeyEntity == null) {
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
    } else {
      childWidget = Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "大家都在搜",
                style: TextStyle(fontSize: 15.0),
              ),
              Wrap(
                  spacing: 10,
                  children: List.generate(
                      hotkeyEntity.data.length,
                      (index) => ActionChip(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                                visible_content = !visible_content;
                                search_content = hotkeyEntity.data[index].name;
                                //将搜索的内容赋值到输入框
                                textEditingController.text = search_content;
                                getArticleData(
                                    0, hotkeyEntity.data[index].name);
                              });
                            },
                            label: Text(
                              hotkeyEntity.data[index].name,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black45),
                            ),
                          )))
            ],
          ));
    }

    return childWidget;
  }

  // ignore: non_constant_identifier_names
  Future GetHoteKey() async {
    Dio dio = new Dio();
    Response response = await dio.get(Api.SEARCH_HOT_KEY_URL);
    HotkeyEntity hotkeyEntity = HotkeyEntity.fromJson(response.data);
    setState(() {
      this.hotkeyEntity = hotkeyEntity;
    });
  }

  Future getArticleData(int count, String content) async {
    Response response;
    Dio dio = Dio();
    String url = Api.SEARCH_RESULT_URL + count.toString() + "/json";
    print(url);
    response = await dio.post(url, queryParameters: {"k": content});
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
      Dio dio = Dio();
      String url = Api.SEARCH_RESULT_URL + count.toString() + "/json";
      print(url);
      response = await dio.post(url, queryParameters: {"k": search_content});

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
}

class ArticleModel {
  ArticleDataData articleDataData;

  ArticleModel(this.articleDataData);
}
