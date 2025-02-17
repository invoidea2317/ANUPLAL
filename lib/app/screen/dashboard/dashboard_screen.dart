import 'dart:async';

import 'package:anuplal/app/screen/account/account_screen.dart';
import 'package:anuplal/app/screen/dashboard/widget/nav_bar_item.dart';
import 'package:anuplal/app/screen/home/home_screen.dart';
import 'package:anuplal/app/screen/store/store_screen.dart';
import 'package:anuplal/controller/auth_controller.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../community/community_screen.dart';



class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  // Timer _timer;
  // int _orderCount;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      const CommunityScreen(),
      StoreScreen(),
      const AccountScreen(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });


  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  Get.find<AuthController>().handleOnWillPop,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize8),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius20)
          ),
          child: Row(children: [
            BottomNavItem(img: Images.icHome, isSelected: _pageIndex == 0, tap: () => _setPage(0), title: 'HOME',),
            BottomNavItem(img: Images.icCommunity, isSelected: _pageIndex == 1, tap: () => _setPage(1), title: 'COMMUNITY',),
            BottomNavItem(img: Images.icStore, isSelected: _pageIndex == 2, tap: () => _setPage(2), title: 'STORE',),
            BottomNavItem(img: Images.icAccount, isSelected: _pageIndex == 3, tap: () => _setPage(3), title: 'ACCOUNT',),
          ]),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
