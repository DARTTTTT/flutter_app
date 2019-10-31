import 'package:flutter/cupertino.dart';

class HeadBottomView extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, 0);//第一个点
    path.lineTo(0, size.height - 30);//第二个点
    var p1 = Offset(size.width / 2, size.height);
    var p2 = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
