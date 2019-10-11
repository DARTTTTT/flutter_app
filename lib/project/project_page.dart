import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/find/find_page.dart';
import 'package:news/home/home_page.dart';
import 'package:news/info/Info.dart';

class Project extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectPage();
  }
}

class ProjectPage extends State<Project> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["完整项目", "跨平台应用", "资源聚合类"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bodyList = [HomePage(), Info(), FindPage()];
    return Scaffold(
      appBar: new TabBar(
          indicatorColor: Colors.red,
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList()),
      body: TabBarView(
        controller: _tabController,
        children: bodyList,
      ),
    );
  }
}
