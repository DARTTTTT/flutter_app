import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/project/item_project_page.dart';
import 'package:news/system/guide_page.dart';
import 'package:news/system/tree_page.dart';

// ignore: must_be_immutable
class ItemGuidePage extends StatelessWidget {
  GuideModel treeModel;
  int index;

  ItemGuidePage(this.treeModel, this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

  var color=  Theme.of(context).primaryColor;
    return DefaultTabController(
      length: treeModel.guideData.articles.length,
      initialIndex: index, //跳到指定的页面
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: color,
            centerTitle: true,
            title: Text(
              treeModel.guideData.name,
              style: TextStyle(fontSize: Content.TEXT_TITLE_SIZE),
            ),
            bottom: TabBar(
                indicatorColor: color,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: List.generate(
                    treeModel.guideData.articles.length,
                    (index) => Tab(
                          text: treeModel.guideData.articles[index].title,
                        ))),
          ),
          preferredSize: Size.fromHeight(Content.BAR_HEIGHT) * 2,
        ),
        body: TabBarView(
          children: List.generate(
              treeModel.guideData.articles.length,
              (index) =>
                  ProjectItemPage(Api.ARTICLE_LIST_URL,treeModel.guideData.articles[index].id)),
        ),
      ),
    );
  }
}
