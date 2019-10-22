import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/view/head_bottom_view.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<LoginPage> {
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 300 + MediaQuery.of(context).padding.top,
            flexibleSpace: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: HeadBottomView(),
                  child: Container(
                    height: 260,
                    color: Colors.red,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 80),
                  child: Hero(
                    tag: 'avatar',
                    child: ClipOval(
                      child: Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: new BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              // border color
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/user_avatar.png")))),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [

                        BoxShadow(
                            color: Colors.red[50],
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            spreadRadius: 3.0),
                      /*  BoxShadow(
                          color: Colors.red[50],
                          offset: Offset(1, 1),
                          blurRadius: 5,
                        ),*/
                        /*      BoxShadow(
                            color: Colors.red[50],
                            offset: Offset(-1, -1),
                            blurRadius: 0),
                        BoxShadow(
                            color: Colors.red[50],
                            offset: Offset(1, -1),
                            blurRadius: 0),*/
                      /*  BoxShadow(
                            color: Colors.red[50],
                            offset: Offset(-1, 1),
                            blurRadius: 5)*/
                      ],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  autofocus: false,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    hintText: "用户名",
                                    prefixIcon: Icon(
                                      Icons.perm_identity,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.black45),
                                  ),
                                  //点击键盘的监听回调
                                  onSubmitted: (val) {},
                                )),
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  autofocus: false,
                                  controller: textEditingController,

                                  decoration: InputDecoration(
                                    hintText: "密码",
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.black45),
                                  ),
                                  //点击键盘的监听回调
                                  onSubmitted: (val) {},
                                )),
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.search,
                                  controller: textEditingController,

                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    hintText: "搜索你要的内容",
                                    fillColor: Colors.transparent,
                                    border: InputBorder.none,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey[100]),
                                  ),
                                  //点击键盘的监听回调
                                  onSubmitted: (val) {},
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pinned: false,
          ),
          SliverToBoxAdapter(child: Text("内容"))
        ],
      ),
    );
  }
}
