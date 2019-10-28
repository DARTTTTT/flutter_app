import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/Content.dart';
import 'package:news/entity/register_entity.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/entity/user_entity.dart';
import 'package:news/view/load_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  bool obscureText = false;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Page();
  }
}

class Page extends State<RegisterPage> {
  TextEditingController textNickController = new TextEditingController();
  TextEditingController textPassController = new TextEditingController();
  TextEditingController textRePassController = new TextEditingController();
  ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> obscureReNotifier = ValueNotifier<bool>(false);

  RegisterEntity registerEntity;

  @override
  void dispose() {
    textNickController.dispose();
    textPassController.dispose();
    textRePassController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
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
            expandedHeight: 420 + MediaQuery.of(context).padding.top,
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
                    height: 270,
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
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: TextField(
                              autofocus: false,
                              controller: textRePassController,
                              cursorColor: Colors.red,
                              obscureText: !obscureReNotifier.value,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "确认密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: ValueListenableBuilder(
                                    valueListenable: obscureReNotifier,
                                    builder: (context, value, child) => Icon(
                                      Icons.remove_red_eye,
                                      size: 18,
                                      color:
                                          value ? Colors.red : Colors.grey[200],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      obscureReNotifier.value =
                                          !obscureReNotifier.value;
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
                          Container(
                            height: 40,
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
                            child: RaisedButton(
                              color: Colors.red,
                              highlightColor: Colors.red[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text(
                                "注册",
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
                          ),
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

  Future postRegister(
      String userName, String pass, String rePass, Function function) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(Api.REGISTER_URL, queryParameters: {
      "username": userName,
      "password": pass,
      "repassword": rePass
    });
    RegisterEntity registerEntity = RegisterEntity.fromJson(response.data);
    setState(() {
      this.registerEntity = registerEntity;
    });
    //此方法关闭加载动画
    function();
    String tip;
    if (registerEntity.errorCode == 0) {
      tip = "注册成功";
      postLogin(userName, pass);
    } else if (registerEntity.errorCode == -1) {
      tip = registerEntity.errorMsg;
    }

    ScaffoldState scaffoldState = Scaffold.of(context);
    scaffoldState.showSnackBar(SnackBar(
      content: Text(
        tip,
        style: TextStyle(fontSize: 15),
      ),
    ));
  }

  _dismissCallBack(Function function) {
    postRegister(textNickController.text, textPassController.text,
        textRePassController.text, function);
  }

  Future postLogin(String userName, String pass) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(Api.LOGIN_URL, queryParameters: {
      "username": userName,
      "password": pass,
    });
    String data = response.data.toString();
    UserEntity userEntity = UserEntity.fromJson(response.data);
    if (userEntity.errorCode == 0) {
      save(data);
    }
  }

  save(String map) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Content.KEY_USER, map);
  }
}
