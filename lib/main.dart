import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //应用名称
      title: '路由传递参数',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "带参数跳转"),
      routes: <String, WidgetBuilder>{
        "/nameRoute": (BuildContext context) => new SecondPage(),
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

class ThirdPage extends StatefulWidget {
  final String title;

   ThirdPage({this.title}) ;

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
    controller=new TextEditingController();
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
