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
  final List<Product>? products;
  final Media? media;

  NearestShop({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openingTime,
    required this.closingTime,
    required this.description,
    required this.products,
    this.media,
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
      description: json['description'],
      products: (json['products'] as List<dynamic>?)
          ?.map((product) => Product.fromJson(product))
          .toList() ?? [],
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final double? discountPrice;
  final String? shortDescription;
  final int? quantity;
  final Media? media;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.discountPrice,
    this.shortDescription,
    this.quantity,
    this.media,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discount_price'] as num?)?.toDouble(),
      shortDescription: json['short_description'],
      quantity: json['quantity'],
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }
}

class Media {
  final int id;
  final String type;
  final String src;

  Media({
    required this.id,
    required this.type,
    required this.src,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      type: json['type'],
      src: json['src'],
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

