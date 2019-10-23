import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/user/login_page.dart';
import 'package:news/view/head_bottom_view.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 200 + MediaQuery.of(context).padding.top,
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
                                              "images/user_avatar.png")))
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        child: Text(
                          "登录/注册",
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
              title: Text("我的收藏"),
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
            SizedBox(
              height: 30,
            )
          ]),
        ),
      ],
    ));
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
            title: Text("我的收藏"),
            onTap: () {
              // Navigator.of(context).pushNamed(RouteName.favouriteList);
            },
            leading: Icon(
              Icons.favorite_border,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text("关于"),
            onTap: () {
              //  switchDarkMode(context);
            },
          ),
          ListTile(
            title: Text("设置"),
            onTap: () {
              //    Navigator.pushNamed(context, RouteName.setting);
            },
            leading: Icon(
              Icons.settings,
              color: iconColor,
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }
}
