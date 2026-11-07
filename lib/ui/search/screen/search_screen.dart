
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/articles/article.dart';
import '../../home/widgets/articles/articles_item.dart';

class SearchScreen extends StatefulWidget {

  final Future<List<Article>> Function(String query) searchArticles;

  const SearchScreen({
    super.key,
    required this.searchArticles,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  Timer? debounce;

  List<Article> articles = [];

  bool isLoading = false;
  bool hasSearched = false;
  String? errorMessage;

  int requestId = 0;

  void onSearchChanged(String value) {
    debounce?.cancel();

    final query = value.trim();
    if (query.isEmpty) {
      requestId++;

      setState(() {
        articles = [];
        isLoading = false;
        hasSearched = false;
        errorMessage = null;
      });

      return;
    }

    debounce = Timer(const Duration(milliseconds: 500), () {
      searchNews(query);
    });
  }

  Future<void> searchNews(String query) async {
    final currentRequestId = ++requestId;

    setState(() {
      isLoading = true;
      errorMessage = null;
      hasSearched = false;
    });

    try {
      final result = await widget.searchArticles(query);
      if (!mounted || currentRequestId != requestId) return;

      setState(() {
        articles = result;
        isLoading = false;
        hasSearched = true;
      });
    } catch (e) {
      if (!mounted || currentRequestId != requestId) return;

      setState(() {
        articles = [];
        isLoading = false;
        hasSearched = true;
        errorMessage = 'Something went wrong. Please try again.';
      });
    }
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged('');
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(height: 16.h),


            TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  onPressed: clearSearch,
                  icon: const Icon(Icons.close),
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: !hasSearched && !isLoading
                  ? const SizedBox()
                  : isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : errorMessage != null
                  ? Center(
                child: Text(errorMessage!),
              )
                  : articles.isEmpty
                  ? const Center(
                child: Text('No articles found'),
              )
                  : ListView.separated(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: articles.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return ArticleItem(
                    article: articles[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
