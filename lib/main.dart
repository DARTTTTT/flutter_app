import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyRowView extends StatefulWidget {
  @override
  _MyRowViewState createState() => _MyRowViewState();
}

class _MyRowViewState extends State<MyRowView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      width: 100,
    );
  }
}

class SwiperView extends StatefulWidget {
  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  List<Widget> imgeList = List();

  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  void initState() {
    imgeList
      ..add(Image.network(
        "https://julian.oss-cn-beijing.aliyuncs.com/zy/ZY新版 升级.png",
        fit: BoxFit.cover,
      ))
      ..add(Image.network(
        "https://julian.oss-cn-beijing.aliyuncs.com/zy/ZY新版 128.png",
        fit: BoxFit.cover,
      ));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("轮播图"),
      ),
      body: ListView(
        children: <Widget>[
          //banner
          firstSwiperView(2),

          TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名和邮箱",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "请输入登录密码",
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),

          Switch(
            value: _switchSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value;
              });
            },
          ),

          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("订阅"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          ),

          Image(
            image: AssetImage("images/bg.png"),
            width: 50,
          ),
          Image(
            image: NetworkImage(
                "https://julian.oss-cn-beijing.aliyuncs.com/zy/ZY新版 升级.png"),
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget firstSwiperView(int size) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        itemCount: size,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: FractionPaginationBuilder(
                color: Colors.white,
                activeColor: Colors.redAccent,
                activeFontSize: 20,
                fontSize: 15)

            /* builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.white,
                activeSize: 6,
                space: 5,
                size: 6)*/
            ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => debugPrint('点击了第$index'),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int dex) {
    return (imgeList[dex]);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "知乎日报",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("知乎"),
        ),

        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context,index){
            return MyHomeCell();
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("第二页"),
      ),
      body: new Center(
        child: new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("返回")),
      ),
    );
  }
}

class newRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("哼"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text("哼哼哈伊"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new NewsListPageState();
  }
}

class NewsListPageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return MyHomeCell();
        },
      ),
    );
  }
}

class MyHomeCell extends StatelessWidget {



  Widget get _cellContentView {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '继山东编导艺考联考被曝疑似出现泄题和作弊的情况。江西编导艺考联考也被曝疑似出现泄题和作弊的情况。',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xff111111),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: 50.0,
                height: 20.0,
                margin: EdgeInsets.only(top: 6.0),
                child: ButtonTheme(
                  buttonColor: Color(0xff1C64CF),
                  shape: StadiumBorder(),
                  child: RaisedButton(
                    onPressed: () => print('test'),
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      '知乎',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                        color:Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 85.0,
          width: 115.0,
          margin: EdgeInsets.only(top: 3.0),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: NetworkImage(
                    "https://julian.oss-cn-beijing.aliyuncs.com/zy/ZY新版 升级.png"),
                    fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 115.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: _cellContentView,
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            color: Color(0xffeaeaea),
            constraints: BoxConstraints.expand(height: 4.0),
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: new Text("计数"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: FlatButton(
          child: Text("$_counter"),
          onPressed: () => setState(() => ++_counter),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 60.0,
        height: 30.0,
        decoration: new BoxDecoration(
            color: _active ? Colors.lightBlue[700] : Colors.grey[600]),
      ),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("test"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("点击"),
            onPressed: () {}),
      ),
    );
  }
}

class Echo extends StatelessWidget {
  const Echo({Key key, @required this.text, this.backgroundColor})
      : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text(text),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  /*  showDialog(context: context,
            builder: (BuildContext context)=>new AlertDialog(title: new Text("请输入"),));*/

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SwiperView();
                  }));

                  /* ScaffoldState _state=context.ancestorStateOfType(
                      TypeMatcher<ScaffoldState>()
                  );

                  _state.showSnackBar(
                    SnackBar(content: Text("我是SnackBar")),

                  );*/
                },
                child: new Text(
                  "点击一下",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
            new Text(
              "textAlign：文本的对齐方式",
              textAlign: TextAlign.center,
              maxLines: 2,
              textScaleFactor: 1.5,
              overflow: TextOverflow.fade,
            ),
            new Text(
              "HELLO KITTY",
              style: TextStyle(
                color: Colors.blue,
                background: new Paint()..color = Colors.amber,
                fontSize: 18,
                height: 2.2,
                fontFamily: "Courier",
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            new Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Home:",
                  style: TextStyle(
                    fontSize: 16,
                    background: new Paint()..color = Colors.grey,
                    color: Colors.white,
                  )),
              TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ))
            ])),
            RaisedButton.icon(
              icon: Icon(Icons.send),
              label: Text("发送"),
              onPressed: () {},
            ),
            OutlineButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: () {},
            ),
            FlatButton.icon(
                onPressed: () {}, icon: Icon(Icons.info), label: Text("详情")),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("HELLO WORLD"),
                  new Text("O(∩_∩)O哈哈~"),
                  new Text(
                    "O(∩_∩)O哈哈~",
                    style: TextStyle(color: Colors.grey, inherit: false),
                  )
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                widthFactor: 20,
                heightFactor: 2,
                child: Text("***"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  final String title;

  ThirdPage({this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ThirdPageState();
  }
}

class _ThirdPageState extends State<ThirdPage> {
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(labelText: "请输入内容"),
            controller: controller,
          ),
          new RaisedButton(
            color: Colors.blue,
            onPressed: () {
              if (controller.text == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                          backgroundColor: Colors.lightBlue,
                          title: new Text("请输入内容"),
                        ));
                return;
              }
              Navigator.pop(context, controller.text);
            },
            child: new Text("确认"),
          )
        ],
      ),
    );
  }
}
