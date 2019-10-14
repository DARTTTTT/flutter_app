import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/find/find_page.dart';
import 'package:news/home/home_page.dart';
import 'package:news/info/Info.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/Content.dart';
import 'package:news/model/project_entity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/project/project_item_page.dart';

class Project extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProjectPage();
  }
}

class ProjectPage extends State<Project> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var  _projectTreeList=[];



  //List tabs = ["完整项目", "跨平台应用", "资源聚合类"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemData();
    _tabController = TabController(length: 26, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    print(_projectTreeList.length);

    Widget childWidget;

    if(_projectTreeList.length==0){
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
    }else{
      childWidget=Scaffold(

        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.red,
            title: TabBar(
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                isScrollable: true,
                tabs: _projectTreeList
                    .map((ProjectData) => Tab(
                  text: ProjectData.name,
                ))
                    .toList()),
          ),
          preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
        ),
        body: TabBarView(
          controller: _tabController,
          children:   List.generate(_projectTreeList.length,
                (index) => ProjectItemPage(_projectTreeList[index].id)),
        ),
      );
    }

    return childWidget;
  }




  //获取列表的请求
  Future getItemData() async {
    Dio dio = Dio();
    Response response = await dio.get(Api.PROJECT_TREE_URL);
    Map data = response.data;
    print("列表: " + data.toString());
    ProjectEntity projectEntity = ProjectEntity.fromJson(data);

    var items = [];
    List<ProjectData> _projectList = projectEntity.data;

    _projectList.forEach((item) {
      items.add(item);
    });

    setState(() {
      this._projectTreeList=items;
    });


  }
}


