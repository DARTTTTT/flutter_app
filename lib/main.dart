import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //应用名称
      title: '首页',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "带参数跳转"),
      routes: <String, WidgetBuilder>{
        "/nameRoute": (BuildContext context) => new Echo(
              text: "嘻嘻",
              backgroundColor: Colors.grey,
            ),
      },
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
  _MyHomePageState createState() => _MyHomePageState();
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
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/nameRoute");
                },
                child: new Text("直接用name跳转")),
            new FlatButton(
                onPressed: () {
                  Navigator.push<String>(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new ThirdPage(title: "请输入昵称");
                  })).then((String result) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            content: new Text("输入的内容是:$result"),
                          );
                        });
                  });
                },
                child: new Text("跳转传参并返回值"))
          ],
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

class _TapboxAState extends State<TapboxA>{

  bool _active=false;

  void _handleTap(){
    setState(() {
      _active=!_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child:  new Center(
          child:  new Text(
            _active?'Active':'Inactive',
            style: new TextStyle(fontSize:  32.0,color: Colors.white),
          ),
        ),
        width: 60.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: _active?Colors.lightBlue[700]:Colors.grey[600]
        ),
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
                    return TapboxA();
                  }));

                  /* ScaffoldState _state=context.ancestorStateOfType(
                      TypeMatcher<ScaffoldState>()
                  );

                  _state.showSnackBar(
                    SnackBar(content: Text("我是SnackBar")),

                  );*/
                },
                child: new Text("点击一下"))
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
