import 'package:anuplal/app/models/orders_model.dart';
import 'package:anuplal/app/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../app/services/api_services.dart';

class OrdersController extends GetxController implements GetxService {
  final ApiService apiService = ApiService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

 List<Order> _order = [];

  List<Order> get order => _order;

  Future<void> getOrdersInfo(OrdersController orders) async {
    dynamic fetchedProducts = await apiService.fetchMyOrders(orders);
  }

  void setOrder(List<Order> order) {
    _order = order;
    update();
  }
}
