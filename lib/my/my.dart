import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/login_model.dart';
import 'package:news/model/theme_model.dart';
import 'package:news/user/like_page.dart';
import 'package:news/user/login_page.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/login_widget.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<MyPage> {
  String colorKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();






  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var loginModel = Provider.of<LoginModel>(context);
    debugPrint("是否登录: " + loginModel.hasUserEntity.toString());


    var color=Theme.of(context).primaryColor;


    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[],
          backgroundColor: Theme.of(context).backgroundColor,
          expandedHeight: 200 + MediaQuery.of(context).padding.top,
          flexibleSpace: ClipPath(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //渐变色
                          colors: [color, color],
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
                          onTap: loginModel.hasUserEntity
                              ? null
                              : () {
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
                          loginModel.hasUserEntity
                              ? loginModel.userEntity.data.nickname
                              : "注册/登录",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onTap: loginModel.hasUserEntity
                            ? null
                            : () {
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
                if (loginModel.hasUserEntity) {
                  Navigator.push(context,
                      new CupertinoPageRoute(builder: (context) => LikePage()));
                } else {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => LoginPage()));
                }
                // Navigator.of(context).pushNamed(RouteName.favouriteList);
              },
              leading: Icon(
                Icons.favorite_border,
                color: color,
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
                color: color,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          SettingThemeWidget(),
            ListTile(
              title: Text("设置"),
              onTap: () {
              //  AppManger.sharedPreferences.setString(Content.KEY_THEME_COLOR, key);

                //    Navigator.pushNamed(context, RouteName.setting);
              },
              leading: Icon(
                Icons.settings,
                color: color,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            Offstage(
              offstage: !loginModel.hasUserEntity,
              child: loginModel.busy
                  ? DialogProgressIndicator("正在退出")
                  : ListTile(
                      title: Text("退出"),
                      onTap: () {
                        loginModel.logout();
                      },
                      leading: Icon(
                        Icons.exit_to_app,
                        color: color,
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
class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("主题"),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries.map((color) {
                return Material(
                  color: color,
                  child: InkWell(
                    onTap: ( ) {
                      Provider.of<ThemeModel>(context).setTheme(color);

                      ThemeModel().saveThemeColor(color);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              }).toList(),
              Material(
                child: InkWell(
                  onTap: () {
                    Provider.of<ThemeModel>(context).setRandomTheme();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Theme.of(context).accentColor)),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}