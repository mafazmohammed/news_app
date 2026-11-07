import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/remote/network/api_manager.dart';
import '../../../../model/sources/Source.dart';
import 'articles_list.dart';

class ArticlesWidget extends StatefulWidget {
  final String categoryId;
  const ArticlesWidget({super.key,required this.categoryId});

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(widget.categoryId),
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
        List<Source> sources = response?.sources??[];
        return DefaultTabController(
          length: sources.length,
          child: Padding(
            padding: REdgeInsetsDirectional.only(
                top: 16,
                start: 16
            ),
            child: Column(
              spacing: 16.h,
              children: [
                TabBar(
                  isScrollable: true,
                  tabs: sources
                      .map((source) => Tab(text: source.name))
                      .toList(),
                ),
                Expanded(child: Padding(
                  padding: REdgeInsetsDirectional.only(end: 16),
                  child: TabBarView(children: sources
                  //sourceId: source.id??"",
                      .map((source) => ArticlesList(sourceId: source.id??"",))
                      .toList()),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}