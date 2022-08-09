// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_revision2/app/app_prefs.dart';
import 'package:flutter_clean_arch_revision2/app/di.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/routes_manager.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/them_manager.dart';

class MyApp extends StatefulWidget {
  //MyApp({Key? key}) : super(key: key);

  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;
  //factory MyApp() => MyApp._internal();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreference _appPreference = instance<AppPreference>();
  @override
  void didChangeDependencies() {
    _appPreference.getAppLcoal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationThem(),
    );
  }
}
