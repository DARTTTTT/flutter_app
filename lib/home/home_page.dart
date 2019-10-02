import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/info_entity.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<HomePage> {
  String dataStr = "";
  var _items = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return layout(context);
  }

  Future getData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.BaseUrl + Api.ARTICLE_LIST);
    Map data = response.data;
    print('返回数据: ' + data.toString());
    InfoEntity infoEntity = InfoEntity.fromJson(data);
    print("解析数据:" + infoEntity.date);
  }
}

Widget layout(BuildContext context) {

  return new Scaffold(
    appBar: new AppBar(
      title: const Text("主页"),
    ),
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: 180.0,
      child: Swiper(
        itemBuilder: _swiperBuilder,
        itemCount: 3,
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.white,
            size: 7.0,
            activeSize: 9.0,
          )
        ),
        control: new SwiperControl(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index)=>print("点击了第$index个"),
      ),
    ),
  );
}

Widget _swiperBuilder(BuildContext context, int index) {
  return (Image.network(
   "https://wanandroid.com/blogimgs/92d96db5-d951-4223-ac42-e13a62899f50.jpeg",
    fit: BoxFit.fill,
  ));



}
