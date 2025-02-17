import 'package:anuplal/app/models/community_model.dart';

class ShopModel {
  final int shopId;
  final String shopName;
  final String shopLogo;
  final double shopRating;
  final bool hasGift;
  final List<ProductModel>? products;

  ShopModel({
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.shopRating,
    required this.hasGift,
    required this.products,
  });

  // Factory method to create ShopModel from JSON
  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      shopId: json['shop_id'],
      shopName: json['shop_name'],
      shopLogo: json['shop_logo'],
      shopRating: json['shop_rating'].toDouble(),
      hasGift: json['has_gift'],
      products: (json['products'] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
    );
  }

  // Method to convert ShopModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'shop_name': shopName,
      'shop_logo': shopLogo,
      'shop_rating': shopRating,
      'has_gift': hasGift,
      'products': products!.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductModel {
  final int id;
  final int quantity;
  final String name;
  final String thumbnail;
  final String brand;
  final double price;
  final double discountPrice;
  final double discountPercentage;
  final double rating;
  final String totalReviews;
  final String totalSold;
  final String? color;
  final String? size;
  final String? unit;
  final String? gift;
  final int shopId;
  final Media? media;

  ProductModel( {
    required this.id,
    required this.quantity,
    required this.name,
    required this.thumbnail,
    required this.brand,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.color,
    this.size,
    this.unit,
    this.gift,
    required this.shopId,
    this.media,
  });

  // Factory method to create ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      quantity: json['quantity'],
      name: json['name'],
      thumbnail: json['thumbnail']??"",
      brand: json['brand']??"",
      price: json['price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      discountPercentage: (json['discount_percentage']??0.0).toDouble(),
      rating: (json['rating']??0.0).toDouble(),
      totalReviews: json['total_reviews']??"",
      totalSold: json['total_sold']??"",
      color: json['color'],
      size: json['size'],
      unit: json['unit'],
      gift: json['gift'],
      shopId: json['shop_id'] ?? 0,
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
    );
  }

  // Method to convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'name': name,
      'thumbnail': thumbnail,
      'brand': brand,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'rating': rating,
      'total_reviews': totalReviews,
      'total_sold': totalSold,
      'color': color,
      'size': size,
      'unit': unit,
      'gift': gift,
      'shop_id': shopId,
      'media': media?.toJson(),
    };
  }
}
