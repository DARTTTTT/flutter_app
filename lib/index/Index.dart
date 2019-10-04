import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/find/find_page.dart';
import 'package:news/home/home_page.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  final items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(
      icon: Icon(Icons.all_inclusive),
      title: Text("发现"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.adjust),
      title: Text("资讯"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_identity),
      title: Text("我的"),
    ),
  ];

  final bodyList = [HomePage(), FindPage(), HomePage(), FindPage()];

  final pageController = PageController();
  int currentIndex = 0;

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          fixedColor: Colors.red,
          type: BottomNavigationBarType.fixed),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList,
        physics: NeverScrollableScrollPhysics(),//不能左右滑动
      ),
    );
  }
}
