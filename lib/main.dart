import 'dart:io';

import 'package:anuplal/utils/app_constants.dart';
import 'package:anuplal/utils/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'helper/gi_dart.dart' as di;
import 'helper/route_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFE4E6DF), // Or use any color of your choice
    statusBarIconBrightness: Brightness.light, // Adjust icon brightness for light/dark status bar
  ));
  await di.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: light,
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: widget!);
      },
    );
  }
}

