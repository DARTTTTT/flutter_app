import 'package:flutter/widgets.dart';

class KeepStateWidget extends StatefulWidget {
  final child;

  KeepStateWidget(this.child);

  @override
  State<StatefulWidget> createState() {
    return KeepStateState(child);
  }
}

class KeepStateState extends State<KeepStateWidget>
    with AutomaticKeepAliveClientMixin {
  final child;


  KeepStateState(this.child);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return child;
  }

  @override
  bool get wantKeepAlive => true;
}
