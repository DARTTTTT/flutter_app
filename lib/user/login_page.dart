import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/user_entity.dart';
import 'package:news/model/login_model.dart';
import 'package:news/user/register_page.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/load_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<LoginPage> {
  TextEditingController textNickController = new TextEditingController();
  TextEditingController textPassController = new TextEditingController();
  ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    textNickController.dispose();
    textPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 400 + MediaQuery.of(context).padding.top,
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
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red[50],
                            offset: Offset(1.0, 1.0),
                            blurRadius: 10.0,
                            spreadRadius: 3.0),
                      ],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: TextField(
                              autofocus: false,
                              controller: textNickController,
                              cursorColor: Colors.red,

                              decoration: InputDecoration(
                                hintText: "用户名",
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey[200],
                                    size: 18,
                                  ),
                                  onTap: () {
                                    textNickController.clear();
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.black45),
                              ),
                              //点击键盘的监听回调
                              onSubmitted: (val) {},
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey[200], width: 0.5))),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: TextField(
                              autofocus: false,
                              controller: textPassController,
                              cursorColor: Colors.red,
                              obscureText: !obscureNotifier.value,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: ValueListenableBuilder(
                                    valueListenable: obscureNotifier,
                                    builder: (context, value, child) => Icon(
                                      Icons.remove_red_eye,
                                      size: 18,
                                      color:
                                          value ? Colors.red : Colors.grey[200],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      obscureNotifier.value =
                                          !obscureNotifier.value;
                                    });
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.black45),
                              ),
                              //点击键盘的监听回调
                              onSubmitted: (val) {},
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey[200], width: 0.5))),
                          ),
                          /* Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
                              child: RaisedButton(
                                color: Colors.red,
                                highlightColor: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  "登录",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return new NetLoadingDialog(
                                          dismissDialog: _dismissCallBack,
                                          outsideDismiss: true,
                                        );
                                      });
                                },
                              ),
                            ),*/
                          LoginButton(textNickController, textPassController),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "还没账号？",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13)),
                                    TextSpan(
                                        text: "去注册",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 13))
                                  ]))
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new CupertinoPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pinned: false,
          ),
          SliverToBoxAdapter(child: Text(""))
        ],
      ),
    );


  }

  _dismissCallBack(Function function) {
    postLogin(textNickController.text, textPassController.text, function);
  }

  Future postLogin(String userName, String pass, Function function) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(Api.LOGIN_URL, queryParameters: {
      "username": userName,
      "password": pass,
    });
    function();

    var jsonData = json.encode(response.data);
    UserEntity userEntity = UserEntity.fromJson(response.data);
    if (userEntity.errorCode == 0) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(Content.KEY_USER, jsonData);
      Navigator.of(context).pop(userEntity.data.username);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: Text(
                userEntity.errorMsg,
                style: TextStyle(fontSize: 15),
              ),
            );
          });
    }
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    print("有:"+model.toString());
    // TODO: implement build
    return LoginButtonWidget(
        child: Text(
          "登录",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        onPressed: () {
          /*var formState = Form.of(context);
          if (formState.validate()) {*/
            model
                .login(nameController.text, passwordController.text)
                .then((value) {
              if (value) {
                Navigator.of(context).pop(true);
              } else {
                print("得到: "+value.toString());
              }
            });
          //}
        });
  }
}

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Colors.red;
    return Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(110),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}

class ButtonProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  ButtonProgressIndicator({this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}
