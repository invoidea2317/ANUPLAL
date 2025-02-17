import 'package:anuplal/app/models/product_model.dart';

import 'categories_model.dart';

class CategoryProducts{

  final dynamic id;
  final dynamic name;
  final dynamic thumbnail;
  final dynamic price;
  final dynamic discount_price;
  final dynamic rating;
  final dynamic total_reviews;
  final dynamic total_sold;
  final dynamic quantity;
  final dynamic is_favorite;
  final List<Product>? products;
  CategoryProducts({this.id, this.name, this.thumbnail, this.price, this.discount_price, this.rating, this.total_reviews, this.total_sold, this.quantity, this.is_favorite,this.products,

  });
  factory CategoryProducts.fromJson(Map<String, dynamic> json) {
    // var colorList = json['colors'] as List;
    // List<ColorOption> colorOptions = colorList.map((color) => ColorOption.fromJson(color)).toList();

    return CategoryProducts(

      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      price: json['price'],
      discount_price: json['discount_price'],
    //  discountPercentage: json['discount_percentage'],
      rating: json['rating'],
      total_reviews: json['total_reviews'],
      total_sold: json['total_sold'],
      quantity: json['quantity'],
      is_favorite: json['is_favorite'],
      products: ((json['products']??[]) as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList(),

    );
  }

}



