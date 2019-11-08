import 'package:dio/dio.dart';
import 'package:news/base/app_repository.dart';
import 'package:news/entity/article_entity.dart';
import 'package:news/entity/banner_entity.dart';
import 'package:news/model/view_state_model.dart';

class HomeModel extends ViewStateModel {
  ArticleEntity _articleEntity;

  ArticleEntity get articleEntity => _articleEntity;

  BannerEntity _bannerEntity;

  BannerEntity get bannerEntity => _bannerEntity;



  HomeModel(){
    article(0);
  }



  Future<bool> article(int count) async {
    setBusy(true);
    try {
      Response response = await AppRepository.article(count);
      ArticleEntity articleEntity = ArticleEntity.fromJson(response.data);
      _articleEntity=articleEntity;
      setBusy(false);
      return true;
    } catch (e) {
      return false;
    }
  }
}
