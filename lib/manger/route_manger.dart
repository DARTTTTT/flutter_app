import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/system/item_tree_page.dart';
import 'package:news/system/tree_page.dart';

class RouteTag {
  static const String structureList = 'structureList';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteTag.structureList:
        var list = routeSettings.arguments as List;
        TreeModel treeModel = list[0];
        int index = list[1];
        print(treeModel.treeData.children[index].name);
        return CupertinoPageRoute(builder: (_) => ItemTreePage(treeModel,index));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${routeSettings.name}'),
                  ),
                ));
    }
  }
}
