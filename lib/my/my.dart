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
import 'package:news/user/user_model.dart';
import 'package:news/view/head_bottom_view.dart';
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
  String userName = "登录/注册";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    var userModel= Provider.of<UserModel>(context);
    print("是否登录: "+userModel.hasUserEntity.toString());
    if(userModel.hasUserEntity==true){
      var loginModel=Provider.of<LoginModel>(context);
      /*String name=loginModel.getLoginName();
      print("昵称:"+name);*/
    }

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
                            padding: EdgeInsets.only(top: 50.0),
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
                              onTap: () {
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
                              userModel.hasUserEntity?"XX":"注册/登录",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            onTap: () {
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
                  offstage: false,
                  child: ListTile(
                    title: Text("退出"),
                    onTap: () {
                    /*  showDialog(
                          context: context,
                          builder: (context) {
                            return new NetLoadingDialog(
                              dismissDialog: _dismissCallBack,
                              outsideDismiss: true,
                            );
                          });
*/

                    /*  var loginModel=Provider.of<LoginModel>(context);
                      loginModel.logout();*/

                      userModel.clearUser();


                      //    Navigator.pushNamed(context, RouteName.setting);
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

  Future get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString(Content.KEY_USER);
    if (user != null) {
      Map<String, dynamic> map = json.decode(user);
      UserEntity userEntity = UserEntity.fromJson(map);
      print("用户名:" + userEntity.data.username);
      userName = userEntity.data.username;
      setState(() {});
    } else {
      userName = "登录/注册";
      setState(() {});
    }
  }

  _dismissCallBack(Function function) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.LOGIN_OUT_URL);
    function();
    UserEntity userEntity = UserEntity.fromJson(response.data);
    if (userEntity.errorCode == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(Content.KEY_USER);
      prefs.clear();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: Text(
                "退出成功",
                style: TextStyle(fontSize: 15),
              ),
            );
          });

      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
            builder: (context) => new Index(),
          ),
              (route) => route == null);
    }
  }
}
