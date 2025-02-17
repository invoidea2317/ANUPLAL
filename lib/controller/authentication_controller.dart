import 'dart:convert';
import 'package:anuplal/app/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app/widgets/commontoast.dart';
import '../helper/route_helper.dart';

class LoginController extends GetxController {
  // URL of the API endpoint
  final String _url = '${baseUrl}send-login-otp';
  final String _otpUrl = '${baseUrl}verify-login-otp';
  // Observables for handling loading and response states
  var isLoading = false.obs;
  var loginResponse = {}.obs;

  // Method to handle login
  Future<void> login(String phone,) async {
    isLoading.value = true; // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(_url),
        // headers: {'Content-Type': 'application/json',  'Authorization': '••••••'},
        body: {'phone': "$phone",},
      );

      if (response.statusCode == 200) {
        loginResponse.value = jsonDecode(response.body);
        print('Login successful: ${loginResponse.value}');
        Get.toNamed(
            RouteHelper.getOtpVerificationRoute(
                phone));
        // CommonToast('Login successful: ${loginResponse.value['otp']}');

      } else {
        print('Failed to login: ${response.body}');
        CommonToast('Failed to login');
      }
    } catch (error) {
      print('Error: $error');
      CommonToast('$error');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> otpVerify(String phone,String otp,) async {
    isLoading.value = true; // Show loading indicator
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse(_otpUrl),
        // headers: {'Content-Type': 'application/json',  'Authorization': '••••••'},
        body: {'phone': "$phone", 'otp': otp},);

      if (response.statusCode == 200) {
        loginResponse.value = jsonDecode(response.body);
        debugPrint('otp successful: ${loginResponse.value}');
        prefs.setString('token', loginResponse.value['token']);
        if(loginResponse.value['message'] == 'Login successful.' && loginResponse.value['user']['register_status'] == 0){
          Get.toNamed(RouteHelper.locationPick);
        } else {
          Get.toNamed(RouteHelper.dashboard);
        }

      } else {
        // print('Failed to otp: ${response.body}');
        // CommonToast('Failed to otp');
      }
    } catch (error) {
      print('Error: $error');
      CommonToast('$error');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

}