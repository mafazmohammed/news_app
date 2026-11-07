import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/providers/theme_provider.dart';
import 'package:news_app/core/resources/routes_manager.dart';
import 'package:news_app/ui/home/screens/home_screen.dart';
import 'package:news_app/ui/search/screen/search_screen.dart';
import 'package:provider/provider.dart';

import 'core/remote/network/api_manager.dart';
import 'core/resources/app_theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
           locale: context.locale,
          // darkTheme: AppTheme.darkTheme,
          themeMode: provider.themeMode,
          theme: AppTheme.lightTheme,
          title: 'News App',
          debugShowCheckedModeBanner: false,
          routes: {
            RoutesManager.homeRoute:(context)=>HomeScreen(),
            RoutesManager.searchRoute:(context)=>SearchScreen(
                searchArticles: (query) async{
                  final response = await ApiManager.searchArticles(query);
                  return response.articles ?? [];
                },
            ),
          },
          initialRoute: RoutesManager.homeRoute,
          home: child,
        );
      },
    );
  }
}

