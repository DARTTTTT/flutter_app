import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/home/ItemDetail.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/guide_entity.dart';
import 'package:news/entity/tree_entity.dart';
import 'package:news/system/item_guide_page.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<GuidePage> with AutomaticKeepAliveClientMixin {
  var treeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var color=  Theme.of(context).primaryColor;

    Widget childWidget;
    if (treeList.length == 0) {
      childWidget = Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle(
              color: color,
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
      childWidget = ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: treeList.length,
          itemBuilder: (context, index) {
            GuideModel treeModel = this.treeList[index];
            return GuideItemWidget(treeModel);
          });
    }
    return childWidget;
  }

  Future getData() async {
    Dio dio = new Dio();
    Response response = await dio.get(Api.SYSTEM_NAVI_URL);
    GuideEntity guideEntity = GuideEntity.fromJson(response.data);
    var items = [];
    List<GuideData> _treeList = guideEntity.data;
    _treeList.forEach((item) {
      items.add(GuideModel(item));
    });
    setState(() {
      this.treeList = items;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// ignore: must_be_immutable
class GuideItemWidget extends StatelessWidget {
  GuideModel treeModel;

  GuideItemWidget(this.treeModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              treeModel.guideData.name,
              style: TextStyle(fontSize: 15.0),
            ),
            Wrap(
                spacing: 10,
                children: List.generate(
                    treeModel.guideData.articles.length,
                    (index) => ActionChip(
                          onPressed: () {
                            print(treeModel.guideData.articles[index].title);
                            /* Navigator.of(context).pushNamed(
                                RouteTag.structureList,
                                arguments: [treeModel, index]);*/

                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (context) => ItemInfoDetail(
                                          isLike: false,
                                          url: treeModel
                                              .guideData.articles[index].link,
                                          title: treeModel
                                              .guideData.articles[index].title,
                                          collect: treeModel.guideData
                                              .articles[index].collect,
                                          id: treeModel
                                              .guideData.articles[index].id,
                                          originId: null
                                        )));
                          },
                          label: Text(
                            treeModel.guideData.articles[index].title,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.black45),
                          ),
                        )))
          ],
        ));
  }
}

class GuideModel {
  GuideData guideData;

  GuideModel(this.guideData);
}
