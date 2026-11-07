import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constant.dart';

import '../../../model/articles/articles_response.dart';
import '../../../model/sources/source_response.dart';

class ApiManager {
  static Dio dio = Dio(
      BaseOptions(
          baseUrl: "https://newsapi.org"
      )
  );
  //
  static Future<SourcesResponse> getSources(String categoryId)async{
    var response = await dio.get("/v2/top-headlines/sources",queryParameters: {
      "apiKey":AppConstant.apiKey,
      "category":categoryId
    });
    var sourcesResponse = SourcesResponse.fromJson(response.data);
    return sourcesResponse;
  }
  static Future<ArticlesResponse> getArticles(String sourceId)async{
    var response = await dio.get("/v2/everything",queryParameters: {
      "apiKey":AppConstant.apiKey,
      "sources":sourceId
    });
    var articlesResponse = ArticlesResponse.fromJson(response.data);
    return articlesResponse;
  }


  static Future<ArticlesResponse> searchArticles(String query) async {
    var response = await dio.get(
      "/v2/everything",
      queryParameters: {
        "apiKey": AppConstant.apiKey,
        "q": query,
        "searchIn": "title,description,content",
      },
    );

    var articlesResponse = ArticlesResponse.fromJson(response.data);
    return articlesResponse;
  }
}