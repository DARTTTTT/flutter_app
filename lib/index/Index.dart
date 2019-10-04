import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/config/global_config.dart';
import 'package:news/find/find_page.dart';
import 'package:news/home/home_page.dart';

import 'navigation_icon_view.dart';


class Index extends StatefulWidget{

  @override
  State<Index> createState()=> new _IndexState();

}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex=0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;


  @override
  void initState(){
    super.initState();
    _navigationViews=<NavigationIconView>[
      new NavigationIconView(
        icon: new Icon(Icons.home),
        title: new Text("首页"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.all_inclusive),
        title: new Text("发现"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.adjust),
        title: new Text("资讯"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.perm_identity),
        title: new Text("我的"),
        vsync: this,
      ),
    ];
    for(NavigationIconView view in _navigationViews){
      view.controller.addListener(_rebuild);
    }

    _pageList =<StatefulWidget>[
      new HomePage(),
      new FindPage(),
    ] ;
    _currentPage=_pageList[_currentIndex];


  }

  void _rebuild() {
    setState((){});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(NavigationIconView view in _navigationViews){
      view.controller.dispose();
    }
  }


  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar bottomNavigationBar=new BottomNavigationBar(
      items: _navigationViews
      .map((NavigationIconView navigationIconView)=>navigationIconView.item)
      .toList(),
      currentIndex:  _currentIndex,
      fixedColor: Colors.red,
      type: BottomNavigationBarType.fixed,
      onTap:(int index){
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex=index;
          _navigationViews[_currentIndex].controller.forward();
          _currentPage=_pageList[_currentIndex];
        });
      } ,

    );



    // TODO: implement build
    return MaterialApp(

      home: new Scaffold(
        body: new Center(
          child: _currentPage,
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
      theme: GlobalConfig.themeData,
    );
  }


}