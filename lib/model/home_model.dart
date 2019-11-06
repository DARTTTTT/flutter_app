import 'dart:math';

import 'package:dio/dio.dart';
import 'package:news/entity/Api.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/banner_entity.dart';
import 'package:news/model/view_state_model.dart';
import 'package:news/utils/net_util.dart';

class HomeModel extends ViewStateModel {
  ArticleEntity _articleEntity;

  ArticleEntity get articleEntity => _articleEntity;

  BannerEntity _bannerEntity;

  BannerEntity get bannerEntity => _bannerEntity;

  Future<bool> article(int count) async {
    setBusy(true);
    String url = Api.ARTICLE_LIST_URL + count.toString() + "/json";
    try {
      Response response = await NetUtil().dio.get(url);
      Map aritcle_data = response.data;
      ArticleEntity articleEntity = ArticleEntity.fromJson(aritcle_data);
      print(articleEntity.data.datas.length);
      _articleEntity=articleEntity;
      setBusy(false);
      return true;
    }catch(e){
      return false;
    }

  }
}
