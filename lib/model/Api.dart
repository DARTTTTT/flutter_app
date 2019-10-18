class Api {
  //base
  static const String BaseUrl = "https://www.wanandroid.com/";

  //轮播图
  static const String BANNER_URL = BaseUrl + "banner/json";

  //主页列表
  static const String ARTICLE_LIST_URL = BaseUrl + "article/list/";

  //工程tabbar
  static const String PROJECT_TREE_URL = BaseUrl + "project/tree/json";

  //工程列表
  static const String PROJECT_LIST_URL = BaseUrl + "project/list/";

  //公众号
  static const String WX_ARTICLE_CHAPTER_URL =
      BaseUrl + "wxarticle/chapters/json";

  //公众号列表
  static const String WX_ARTICLE_CHAPTER_LIST_URL = BaseUrl + "wxarticle/list/";

  //体系
  static const String SYSTEM_TREE_URL = BaseUrl + "tree/json";

//导航
  static const String SYSTEM_NAVI_URL = BaseUrl + "navi/json";

  //搜索热词
  static const String SEARCH_HOT_KEY_URL = BaseUrl + "hotkey/json";
  //搜索
  static const String SEARCH_RESULT_URL=BaseUrl+"article/query/";
}
