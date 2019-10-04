import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/model/Api.dart';
import 'package:news/model/banner_entity.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Page();
  }
}

class Page extends State<HomePage> {
  String dataStr = "";
  List<String> _picList = new List();
  var _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      /*  appBar: new AppBar(
      title: const Text("主页"),
    ),*/

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 180.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            ImagesModel im = this._items[index];
            return (Image.network(
              im.pic.imagePath,
              fit: BoxFit.fill,
            ));
          },
          itemCount: _items.length,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.red,
            size: 7.0,
            activeSize: 7.0,
          )),
          control: null,
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print("点击了第$index个"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return layout(context);
  }

  Future getData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.BaseUrl + Api.BANNER_URL);
    Map data = response.data;
    print("返回数据: " + data.toString());
    BannerEntity bannerEntity = BannerEntity.fromJson(data);
    var items = [];
    List<BannerData> _picList=bannerEntity.data;


    //遍历添加到数组当中去
    _picList.forEach((item) {
      items.add(ImagesModel(item));
    });

    setState(() {
      _items = items;
    });
  }
}

class ImagesModel {
  BannerData pic;

  ImagesModel(this.pic);
}
