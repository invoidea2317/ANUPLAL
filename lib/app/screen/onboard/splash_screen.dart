import 'dart:async';

import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _route();
    super.initState();
  }

  void _route() {
    Timer(const Duration(seconds: 1), () async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('token') != null && prefs.getString('token') != '') {
        Get.toNamed(RouteHelper.getDashboardRoute());
      } else {
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: Get.size.height,
        width: Get.size.width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          // color: Colors.white,
            image: DecorationImage(image: AssetImage(Images.authBg),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSize50),
          child: Image.asset(Images.logo,height: 140,width: 100,),
        ),
      ),
    );
  }
}
