import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/tree_entity.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<TreePage> with AutomaticKeepAliveClientMixin {
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

    Widget childWidget;
    if (treeList.length == 0) {
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
      childWidget = ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: treeList.length,
          itemBuilder: (context, index) {
            TreeModel treeModel = this.treeList[index];
            return TreeItemWidget(treeModel);
          });
    }
    return childWidget;
  }

  Future getData() async {
    Dio dio = new Dio();
    Response response = await dio.get(Api.SYSTEM_TREE_URL);
    TreeEntity treeEntity = TreeEntity.fromJson(response.data);
    var items = [];
    List<TreeData> _treeList = treeEntity.data;
    _treeList.forEach((item) {
      items.add(TreeModel(item));
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
class TreeItemWidget extends StatelessWidget {
  TreeModel treeModel;

  TreeItemWidget(this.treeModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              treeModel.treeData.name,
              style: TextStyle(fontSize: 15.0),
            ),
            Wrap(
                spacing: 10,
                children: List.generate(
                    treeModel.treeData.children.length,
                    (index) => ActionChip(
                          onPressed: () {

                          },
                          label: Text(
                            treeModel.treeData.children[index].name,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.black45),
                          ),
                        )))
          ],
        ));
  }
}

class TreeModel {
  TreeData treeData;
  TreeModel(this.treeData);
}
