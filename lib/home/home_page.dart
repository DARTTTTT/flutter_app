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

Widget layout(BuildContext context,  List<String> _picList) {
  return new Scaffold(
    /*  appBar: new AppBar(
      title: const Text("主页"),
    ),*/

    body: Container(
      width: MediaQuery.of(context).size.width,
      height: 180.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          /* List<String> picList = [
            "https://wanandroid.com/blogimgs/92d96db5-d951-4223-ac42-e13a62899f50.jpeg",
            "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
            "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
            "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png"
          ];*/
          return (Image.network(
            _picList[index],
            fit: BoxFit.fill,
          ));
        },
        itemCount: _picList.length,
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

class Page extends State<HomePage> {
  String dataStr = "";
  List<String> _picList = new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<String> picList = [
      "https://wanandroid.com/blogimgs/92d96db5-d951-4223-ac42-e13a62899f50.jpeg",
      "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
      "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
      "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png"
    ];
    return layout(context, picList);
  }

  Future getData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.BaseUrl + Api.BANNER_URL);
    Map data = response.data;
    print("返回数据: " + data.toString());
    BannerEntity bannerEntity = BannerEntity.fromJson(data);
    print('解析数据: ' + bannerEntity.toString());
    _picList = bannerEntity.data.cast<String>();
    print(_picList.length);
  }
}
