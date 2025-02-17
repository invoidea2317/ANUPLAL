import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_products.dart';
import '../models/product_model.dart';


class CategoryApiService {
  final String imageBaseUrl = "https://anup.lab5.invoidea.in";
  final String url = 'https://anup.lab5.invoidea.in/api/products';

  Future<List<CategoryProducts>> fetchPopularProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categoryproductsJson = data['data']['Catrgorypopular_products'];
      return categoryproductsJson.map((productJson) => CategoryProducts.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load popular products');
    }
  }
}
