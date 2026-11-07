import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/remote/network/api_manager.dart';
import '../../../../model/articles/Article.dart';
import 'articles_item.dart';
class ArticlesList extends StatefulWidget {

  final String sourceId;
  const ArticlesList({super.key,required this.sourceId});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getArticles(widget.sourceId),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Internet Connection"),
                ElevatedButton(onPressed: () {
                  setState(() {

                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        var response = snapshot.data;
        if(response?.status == "error"){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(response?.message??""),
                ElevatedButton(onPressed: () {
                  setState(() {

                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        List<Article> articles = response?.articles??[];
        if(articles.isEmpty){
          return Center(child: Text("No articles found",style: Theme.of(context).textTheme.headlineMedium,),);
        }
        return ListView.separated(
            itemBuilder: (context, index) => ArticleItem(article: articles[index],),
            separatorBuilder: (context, index) => SizedBox(height: 16.h,),
            itemCount: articles.length
        );
      },
    );
  }
}