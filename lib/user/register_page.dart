import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/entity/register_entity.dart';
import 'package:news/model/login_model.dart';
import 'package:news/view/head_bottom_view.dart';
import 'package:news/view/login_widget.dart';
import 'package:oktoast/oktoast.dart';

import '../main.dart';

// ignore: must_be_immutable
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
   var color= Theme.of(context).primaryColor;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 370 + MediaQuery.of(context).padding.top,
            flexibleSpace: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: HeadBottomView(),
                  child: Container(
                    height: 260,
                    color: color,
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
                              cursorColor: color,

                              decoration: InputDecoration(
                                hintText: "用户名",
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: color,
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
                              cursorColor: color,
                              obscureText: !obscureNotifier.value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: color,
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: ValueListenableBuilder(
                                    valueListenable: obscureNotifier,
                                    builder: (context, value, child) => Icon(
                                      Icons.remove_red_eye,
                                      size: 18,
                                      color:
                                          value ? color : Colors.grey[200],
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
                              cursorColor:color,
                              obscureText: !obscureReNotifier.value,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "确认密码",
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: color,
                                  size: 18,
                                ),
                                suffixIcon: InkWell(
                                  child: ValueListenableBuilder(
                                    valueListenable: obscureReNotifier,
                                    builder: (context, value, child) => Icon(
                                      Icons.remove_red_eye,
                                      size: 18,
                                      color:
                                          value ? color : Colors.grey[200],
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
                          RegisterButton(textNickController,textPassController,textRePassController),
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
class RegisterButton extends StatelessWidget {
  final nameController;
  final passwordController;
  final rePassController;

  RegisterButton(this.nameController, this.passwordController,this.rePassController);

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<LoginModel>(context);
    // TODO: implement build
    return LoginButtonWidget(
        child: loginModel.busy
            ? ButtonProgressIndicator()
            : Text(
          "注册",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        onPressed: loginModel.busy?null:() {
          if (nameController.text == "") {
            showToast("请输入账号");
          } else if (passwordController.text == "") {
            showToast("请输入密码");
          } else if(rePassController.text==""){
            showToast("请再次输入密码");
          }else {
            loginModel.register(nameController.text, passwordController.text,rePassController.text)
                .then((value) {
              if (value) {
                showToast("注册成功");
                Navigator.of(context).pop(true);
              } else {
                showToast("注册失败");
              }
            });
          }
        });
  }
}