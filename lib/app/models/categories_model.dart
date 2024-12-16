import 'community_model.dart';

class NearestShop {
  final int id;
  final String? name;

  final String? address;
  final String? latitude;
  final String? longitude;
  final String? openingTime;
  final String? closingTime;
  final String? description;
  final List<Category>? categories;
  final Media? mediaLogo;

  NearestShop({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingTime,
    required this.closingTime,
    required this.description,
    required this.categories,
    this.mediaLogo,
  });

  factory NearestShop.fromJson(Map<String, dynamic> json) {
    return NearestShop(
      id: json['id'],
      name: json['name'],

      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],

      categories: ((json['categories']??[]) as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList(),
      mediaLogo: json['media_logo'] != null
          ? Media.fromJson(json['media_logo'])
          : null,
      description: json['description'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final List<Product> products;
  final Media? media;

  Category({
    required this.id,
    required this.name,
    required this.products,
    this.media,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      products: ((json['products']??[]) as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList(),
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final Media? media;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.media,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name']??"",
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity']??0,
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }
}

