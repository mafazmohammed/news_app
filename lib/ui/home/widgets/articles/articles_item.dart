import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/articles/article.dart';
class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem({super.key,required this.article});


  Future<void> openArticle(String? articleUrl) async {
    if (articleUrl == null || articleUrl.isEmpty) {
      debugPrint('Article URL is not available');
      return;
    }

    final Uri? uri = Uri.tryParse(articleUrl);

    if (uri == null ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      debugPrint('Invalid article URL');
      return;
    }

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      debugPrint('Could not open the article');
    }
  }


  void showArticlePreview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.urlToImage ?? '',
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 190,
                      child: Center(child: Icon(Icons.image_not_supported)),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Text(
                article.title ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                article.description ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    openArticle(article.url);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Full Article'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showArticlePreview(context);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary
            )
        ),
        child: Column(
          spacing: 10.h,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(article.urlToImage??"",height: 220.h,fit: BoxFit.cover,)),
            Text(article.title??"",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 16.sp
            ),),
            Row(
              children: [
                Expanded(child: Text("By : ${article.author??""}",style: Theme.of(context).textTheme.titleSmall,)),
                Text(timeago.format(DateTime.parse(article.publishedAt??"")),style: Theme.of(context).textTheme.titleSmall),
              ],
            )
          ],
        ),
      ),
    );
  }
}