import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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