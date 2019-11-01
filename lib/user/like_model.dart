
import 'package:flutter/cupertino.dart';
import 'package:news/entity/article_entity.dart';

class LikeModel extends ChangeNotifier{

  static final Map<int,bool> map=new Map();


  static refresh(List<ArticleDataData> list) {
    list.forEach((article) {
      if (map.containsKey(article.id)) {
        map[article.id] = article.collect;
      }
    });
  }

  replaceAll(List ids){
    print(ids);
      map.clear();
      //ids.forEach((id) => map[id] = true);
      ids.forEach((id){
        map[id]=true;
      });

    notifyListeners();
  }

  addLike(int id){
    map[id]=true;
    notifyListeners();
  }

  removeLike(int id){
    print("移除的是:"+id.toString());
    map[id]=false;
    notifyListeners();
  }

  contains(id){
    return map.containsKey(id);
  }

  operator [](int id) {
    return map[id];
  }

}