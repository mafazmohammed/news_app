
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';

class AppDrawer extends StatefulWidget {
  final void Function() unSelectCategory;

  const AppDrawer({super.key, required this.unSelectCategory});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      width: 269.w,
      backgroundColor: ColorsManager.lightPrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          Container(
            color: ColorsManager.lightSecondaryColor,
            width: double.infinity,
            alignment: Alignment.center,
            padding: REdgeInsets.symmetric(vertical: 65),
            child: Text(
              'app_title'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          SizedBox(height: 16.h),

          InkWell(
            onTap: () {
              widget.unSelectCategory();
            },
            child: Padding(
              padding: REdgeInsetsDirectional.only(start: 16),
              child: Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    AssetsManager.home,
                    height: 24.h,
                    width: 24.w,
                  ),
                  Text(
                    'go_to_home'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: 237.w,
            child: const Divider(
              color: ColorsManager.lightSecondaryColor,
            ),
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: REdgeInsetsDirectional.only(start: 16),
            child: Row(
              spacing: 8.w,
              children: [
                SvgPicture.asset(
                  AssetsManager.paint,
                  height: 24.h,
                  width: 24.w,
                ),
                Text(
                  'theme'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: REdgeInsetsDirectional.only(start: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(18),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: themeProvider.themeMode,
                  isExpanded: true,
                  dropdownColor: ColorsManager.lightPrimaryColor,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        'dark'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        'light'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        'system'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.switchMode(value);
                    }
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: 237.w,
            child: const Divider(
              color: ColorsManager.lightSecondaryColor,
            ),
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: REdgeInsetsDirectional.only(start: 16),
            child: Row(
              spacing: 8.w,
              children: [
                SvgPicture.asset(
                  AssetsManager.globe,
                  height: 24.h,
                  width: 24.w,
                ),
                Text(
                  'language'.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: REdgeInsetsDirectional.only(start: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(18),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: context.locale,
                  isExpanded: true,
                  dropdownColor: ColorsManager.lightPrimaryColor,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Text(
                        'english'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: const Locale('ar'),
                      child: Text(
                        'arabic'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                  onChanged: (locale) {
                    if (locale != null) {
                      context.setLocale(locale);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
