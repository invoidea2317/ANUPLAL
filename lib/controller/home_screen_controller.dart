import 'package:anuplal/app/models/category_products.dart';
import 'package:anuplal/app/models/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app/models/cart_model.dart';

import '../app/models/categories_model.dart' as categoriesModel;
import '../app/models/product_model.dart';
import '../app/services/api_services.dart';

class HomeScreenController extends GetxController implements GetxService {
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  List<PopularProduct> _products = [];

  List<PopularProduct> get products => _products;
  String _categoryName = "";

  String get categoryName => _categoryName;
  List<CategoryProducts> _categories = [];

  List<CategoryProducts> get categories => _categories;
  List<PopularProduct> _particularCategoriesproducts = [];

List<ShopModel> get shopModel => _shopModel;
   List<ShopModel> _shopModel = [];

  List<PopularProduct> get particularCategoriesproducts =>
      _particularCategoriesproducts;

  Product _productsDetails = Product(
    id: 0,
    name: "",
    description: "",
    price: 0,
    shortDescription: '',
    discountPrice: 0,
    discountPercentage: 0,
    rating: 0,
    totalReviews: 0,
    totalSold: 0,
    quantity: 0,
    isFavorite: false,
    thumbnails: [],
    sizes: [],
    colors: [],
    brand: '',
    shop: ShopOfProduct(
        id: 0,
        name: "",
        logo: "",
        rating: 0,
        estimatedDeliveryTime: "",
        deliveryCharge: 0),
  );

  Product get productsDetails => _productsDetails;

  void setPopularProducts(List<PopularProduct> val) {
    _products = val;
    update();
  }

  void setCategories(List<CategoryProducts> val) {
    _categories = val;
    update();
  }

  void Categoriesproducts(List<PopularProduct> val) {
    _particularCategoriesproducts = val;
    update();
  }

  Future<void> fetchProducts(HomeScreenController controller) async {
    dynamic fetchedProducts = await apiService.fetchPopularProducts(controller);
    if (fetchedProducts) {
      _isLoading = false;
    }
  }

  Future<bool> fetchParticularCategory(
      HomeScreenController controller, String id) async {
    _categoryName =
        _categories.firstWhere((element) => element.id.toString() == id).name;
    dynamic fetchedProducts =
        await apiService.fetchParticularCategoriesProducts(controller, id);
    if (fetchedProducts) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchParticularDetails(
      HomeScreenController controller, String id, String shopId) async {
    debugPrint("id $id");
    dynamic fetchedProducts =
        await apiService.fetchProductsDetails(controller, id, shopId);
    if (fetchedProducts) {
      return true;
    } else {
      return false;
    }
  }

  void setPopularProductsDetails(Product val) {
    _productsDetails = val;
    update();
  }

  Future<void> addToCart(
      HomeScreenController controller, String id) async {
      await apiService.addToCartApi(controller, id).then((value){
        debugPrint("value $value");
      });
    // if (fetchedProducts) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
  Future<void> addToCartListing(
      List<ShopModel> shopModel) async {
    _shopModel = shopModel;
     update();
  }

  // List<dynamic> _finalProducts = [];
  //
  // List<dynamic> get finalProducts => _finalProducts;
  //
  // void setFinalProducts(List<dynamic> val) {
  //   _finalProducts = val;
  //
  //   for (var i = 0; i < _finalProducts.length; i++) {
  //     _totalPrice += double.parse(finalProducts[i]['price'].toString());
  //   }
  //
  //   debugPrint(finalProducts.toString());
  //   update();
  // }

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  void setTotalPrice(double val) {
    _totalPrice = val;
    update();
  }

}
