import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class AddressController extends GetxController implements GetxService {

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  String? _address;
  String? get address => _address;
  TextEditingController addressController = TextEditingController();
  String? _lat;
  String? get lat => _lat;
  String? _long;
  String? get long => _long;


  void setAddress(String address) {
    _address = address;
    addressController.text = address;
    update();
  }

  void setLat(String lat) {
    _lat = lat;
    update();
  }

  void setLong(String long) {
    _long = long;
    update();
  }


}