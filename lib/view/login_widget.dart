import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/entity/Content.dart';

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
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

// ignore: camel_case_types
class DialogProgressIndicator extends StatelessWidget {
  final String text;

  DialogProgressIndicator(this.text);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingCircle(
            color: color,
            size: 30.0,
          ),
          new Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            text,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TitleBar extends StatelessWidget {
  String text;

  TitleBar(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var color = Theme.of(context).primaryColor;
    return PreferredSize(
      child: AppBar(
        backgroundColor: color,
        title: Text(
          text,
          style:
              TextStyle(fontSize: Content.TEXT_TITLE_SIZE, color: Colors.white),
        ),
      ),
      preferredSize: Size.fromHeight(Content.BAR_HEIGHT),
    );
  }
}
