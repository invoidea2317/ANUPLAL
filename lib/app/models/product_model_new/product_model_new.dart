import 'dart:convert';

class ProductResponse {
  final List<Product> products;

  ProductResponse({required this.products});

  factory ProductResponse.fromJson(String str) => ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
  };
}

class Product {
  final int id;
  final String name;
  final String? nameAr;
  final String? slug;
  final String? code;
  final int? shopId;
  final int? mediaId;
  final int? brandId;
  final double price;
  final int quantity;
  final int minOrderQuantity;
  final double discountPrice;
  final String shortDescription;
  final String? shortDescriptionAr;
  final String description;
  final String? descriptionAr;
  final bool isActive;
  final bool isNew;
  final bool isFeatured;
  final bool isApprove;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? unitId;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final Media? media;

  Product({
    required this.id,
    required this.name,
    this.nameAr,
    this.slug,
    this.code,
    this.shopId,
    this.mediaId,
    this.brandId,
    required this.price,
    required this.quantity,
    required this.minOrderQuantity,
    required this.discountPrice,
    required this.shortDescription,
    this.shortDescriptionAr,
    required this.description,
    this.descriptionAr,
    required this.isActive,
    required this.isNew,
    required this.isFeatured,
    required this.isApprove,
    required this.createdAt,
    required this.updatedAt,
    this.unitId,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.media,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    slug: json["slug"],
    code: json["code"],
    shopId: json["shop_id"],
    mediaId: json["media_id"],
    brandId: json["brand_id"],
    price: json["price"].toDouble(),
    quantity: json["quantity"],
    minOrderQuantity: json["min_order_quantity"],
    discountPrice: json["discount_price"].toDouble(),
    shortDescription: json["short_description"],
    shortDescriptionAr: json["short_description_ar"],
    description: json["description"],
    descriptionAr: json["description_ar"],
    isActive: json["is_active"] == 1,
    isNew: json["is_new"] == 1,
    isFeatured: json["is_featured"] == 1,
    isApprove: json["is_approve"] == 1,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    unitId: json["unit_id"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    media: json["media"] != null ? Media.fromMap(json["media"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "slug": slug,
    "code": code,
    "shop_id": shopId,
    "media_id": mediaId,
    "brand_id": brandId,
    "price": price,
    "quantity": quantity,
    "min_order_quantity": minOrderQuantity,
    "discount_price": discountPrice,
    "short_description": shortDescription,
    "short_description_ar": shortDescriptionAr,
    "description": description,
    "description_ar": descriptionAr,
    "is_active": isActive ? 1 : 0,
    "is_new": isNew ? 1 : 0,
    "is_featured": isFeatured ? 1 : 0,
    "is_approve": isApprove ? 1 : 0,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "unit_id": unitId,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "media": media?.toMap(),
  };
}

class Media {
  final int id;
  final String type;
  final String name;
  final String? originalName;
  final String src;
  final String? extension;
  final DateTime createdAt;
  final DateTime updatedAt;

  Media({
    required this.id,
    required this.type,
    required this.name,
    this.originalName,
    required this.src,
    this.extension,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    originalName: json["original_name"],
    src: json["src"],
    extension: json["extention"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "name": name,
    "original_name": originalName,
    "src": src,
    "extention": extension,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
