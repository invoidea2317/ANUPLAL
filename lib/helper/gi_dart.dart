
import 'package:anuplal/controller/auth_controller.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:anuplal/controller/product_controller.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/address_controller.dart';


Future<void>   init() async {
  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));




  // Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));



  /// Controller
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => HomeScreenController());
  Get.lazyPut(() => AddressController());


}
