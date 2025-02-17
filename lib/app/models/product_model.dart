// popular_product.dart
class PopularProduct {
  final int id;
  final String name;
  final String thumbnail;
  final double price;
  final double discountPrice;
  final double discountPercentage;
  final double rating;
  final String totalReviews;
  final String totalSold;
  final int quantity;
  final bool isFavorite;
  final List<ColorOption> colors;
  final Shop shop;

  PopularProduct({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.rating,
    required this.totalReviews,
    required this.totalSold,
    required this.quantity,
    required this.isFavorite,
    required this.colors,
    required this.shop,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) {
    var colorList = json['colors'] as List;
    List<ColorOption> colorOptions = colorList.map((color) => ColorOption.fromJson(color)).toList();

    return PopularProduct(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      price: json['price'],
      discountPrice: json['discount_price'],
      discountPercentage: json['discount_percentage'],
      rating: json['rating'],
      totalReviews: json['total_reviews'],
      totalSold: json['total_sold'],
      quantity: json['quantity'],
      isFavorite: json['is_favorite'],
      colors: colorOptions,
      shop: Shop.fromJson(json['shop']),
    );
  }
}

class ColorOption {
  final int id;
  final String name;

  ColorOption({required this.id, required this.name});

  factory ColorOption.fromJson(Map<String, dynamic> json) {
    return ColorOption(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Shop {
  final int id;
  final String name;
  final String logo;
  final double rating;
  final String estimatedDeliveryTime;
  final double deliveryCharge;

  Shop({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.estimatedDeliveryTime,
    required this.deliveryCharge,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      rating: json['rating'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      deliveryCharge: json['delivery_charge'],
    );
  }
}
