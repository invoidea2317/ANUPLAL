import 'package:anuplal/app/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../app/services/api_services.dart';

class CartController extends GetxController implements GetxService {
  final ApiService apiService = ApiService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String,dynamic>> products = [];

  void setCartProducts(List<Map<String,dynamic>> val) {
    products = val;
    update();
  }

}