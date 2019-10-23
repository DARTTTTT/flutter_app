import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/register_entity.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/load_page.dart';

class RegisterPage extends StatefulWidget {
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

  RegisterEntity registerEntity;

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
                                suffixIcon: Icon(
                                  Icons.clear,
                                  color: Colors.grey[200],
                                  size: 18,
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

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                suffixIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey[200],
                                  size: 18,
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

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "确认密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                suffixIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey[200],
                                  size: 18,
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
                                        outsideDismiss: false,
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

  Future postRegister(String userName, String pass, String rePass,Function function) async {
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
    function();
    String tip = null;
    if (registerEntity.errorCode == 0) {
      tip = "注册成功";
    } else if (registerEntity.errorCode == -1) {
      tip = registerEntity.errorMsg;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(
              tip,
              style: TextStyle(fontSize: 15),
            ),
          );
        });
  }

  _dismissCallBack(Function function) {

    postRegister(textNickController.text, textPassController.text,
        textRePassController.text,function);
  }
}
