import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../model/category_model.dart';
import 'category_item.dart';

class CategoriesWidget extends StatelessWidget {
  final void Function(CategoryModel) onCategoryClicked;
  const CategoriesWidget({super.key,required this.onCategoryClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Text(
            StringsManager.welcome,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500
          ),),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => CategoryItem(
                  onCategoryClicked: onCategoryClicked,
                  index: index,
                  category: CategoryModel.categories[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 16.h,
                ),
                itemCount:CategoryModel.categories.length
            ),
          )
        ],
      ),
    );
  }
}