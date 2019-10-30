import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/entity//Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/user_entity.dart';
import 'package:news/index/Index.dart';
import 'package:news/model/login_model.dart';
import 'package:news/user/login_page.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/login_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<MyPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build




    var userModel= Provider.of<LoginModel>(context);
    print("是否登录: "+userModel.hasUserEntity.toString());
    var loginModel=Provider.of<LoginModel>(context);

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[],
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              expandedHeight: 200 + MediaQuery
                  .of(context)
                  .padding
                  .top,
              flexibleSpace: ClipPath(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            //渐变色
                              colors: [Colors.red, Colors.red],
                              //  blue deepOrangeAccent
                              begin: Alignment.centerRight,
                              //起点
                              end: Alignment(-1.0, -1.0))), //终点
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 90.0),
                            child: InkWell(
                              child: Hero(
                                tag: "avatar",
                                child: ClipOval(
                                  child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          // border color
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/user_avatar.png")))),
                                ),
                              ),
                              onTap: userModel.hasUserEntity?null:() {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LoginPage()));

                                //   print("返回的数据: "+result.toString());
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            child: Text(
                              userModel.hasUserEntity?userModel.userEntity.data.nickname:"注册/登录",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            onTap:userModel.hasUserEntity?null: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                clipper: HeadBottomView(),
              ),
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  title: Text("收藏"),
                  onTap: () {
                    // Navigator.of(context).pushNamed(RouteName.favouriteList);
                  },
                  leading: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  title: Text("关于"),
                  onTap: () {
                    //  switchDarkMode(context);
                  },
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  title: Text("设置"),
                  onTap: () {
                    //    Navigator.pushNamed(context, RouteName.setting);
                  },
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
                Offstage(
                  offstage: !userModel.hasUserEntity,
                  child: ListTile(
                    title: Text("退出"),
                    onTap: () {
                      loginModel.logout();
                    },
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ]),
            ),
          ],
        ));


  }

}
