import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class AuthController extends GetxController implements GetxService {

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;
  DateTime? lastBackPressTime;

  Future<bool> handleOnWillPop() async {
    final now = DateTime.now();

    if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
      updateLastBackPressTime(now);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      SystemNavigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }
  void updateLastBackPressTime(DateTime time) {
    lastBackPressTime = time;
    update();
  }

}