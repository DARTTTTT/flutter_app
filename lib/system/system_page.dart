import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/entity/Content.dart';
import 'package:news/system/guide_page.dart';
import 'package:news/system/tree_page.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<SystemPage> {
  List tabs = ["体系", "导航"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color=Theme.of(context).primaryColor;
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: color,
            centerTitle: true,
            title: TabBar(
                indicatorColor: color,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                labelStyle: TextStyle(fontSize: Content.TEXT_TITLE_SIZE),

                tabs: tabs
                    .map((e) => Tab(
                          text: e,
                        ))
                    .toList()),
          ),
          preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
        ),
        body: TabBarView(
          children:[TreePage(),GuidePage()],
        ),
      ),
    );
  }
}
