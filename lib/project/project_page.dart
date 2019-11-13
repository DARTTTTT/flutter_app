import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/project_entity.dart';
import 'package:news/project/item_project_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<ProjectPage> with SingleTickerProviderStateMixin {


  var _projectTreeList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  var color=  Theme.of(context).primaryColor;

    Widget childWidget;
    if (_projectTreeList.length == 0) {
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
      childWidget = DefaultTabController(
        length: _projectTreeList.length,
        child: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: color,
              title: TabBar(
                  indicatorColor: color,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: Content.TEXT_TITLE_SIZE),
                  tabs: _projectTreeList
                      .map((ProjectData) => Tab(
                            text: ProjectData.name,
                          ))
                      .toList()),
            ),
            preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
          ),
          body: TabBarView(
            children: List.generate(_projectTreeList.length,
                (index) => ProjectItemPage(Api.PROJECT_LIST_URL,_projectTreeList[index].id)),
          ),
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
    ProjectEntity projectEntity = ProjectEntity.fromJson(data);

    var items = [];
    List<ProjectData> _projectList = projectEntity.data;

    _projectList.forEach((item) {
      items.add(item);
    });

    setState(() {
      this._projectTreeList = items;
    });
  }
}
