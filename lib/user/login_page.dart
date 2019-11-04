import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/config/manger.dart';
import 'package:news/entity/Content.dart';
import 'package:news/model/login_model.dart';
import 'package:news/user/register_page.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/login_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

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
  String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      username=AppManger.sharedPreferences.getString(Content.KEY_USER_NAME);
      textNickController.text = (username == null ? "" : username);
    });

  }

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
            expandedHeight: 350 + MediaQuery.of(context).padding.top,
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



}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<LoginModel>(context);
    // TODO: implement build
    return LoginButtonWidget(
        child: loginModel.busy
            ? ButtonProgressIndicator()
            : Text(
                "登录",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
        onPressed: loginModel.busy?null:() {
          if (nameController.text == "") {
              showToast("请输入账号");
          } else if (passwordController.text == "") {
            showToast("请输入密码");
          } else {
            loginModel.login(nameController.text, passwordController.text)
                .then((value) {
              if (value) {
                showToast("登录成功");
                Navigator.of(context).pop(true);
              } else {
                showToast("登录失败");
              }
            });
          }
        });
  }
}


