import 'package:anuplal/app/models/community_model.dart';

import 'cart_model.dart';

class Order {
  int id;
  String orderCode;
  int quantity;
  double amount;
  String paymentMethod;
  String paymentStatus;
  String orderStatus;
  String createdAt;
  String placedAt;
  Address? address; // Nullable
  String? gift;
  final List<ProductModel>? products; // Make media nullable

  Order({
    required this.id,
    required this.orderCode,
    required this.quantity,
    required this.amount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.placedAt,
    this.address, // Nullable
    this.gift,
    this.products, // Nullable
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderCode: json['order_code'],
      quantity: json['quantity'],
      amount: json['amount'].toDouble(),
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      createdAt: json['created_at'],
      placedAt: json['placed_at'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      gift: json['gift'],
      products: ((json['products']??[]) as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(), // Handle null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'quantity': quantity,
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'created_at': createdAt,
      'placed_at': placedAt,
      'address': address?.toJson(), // Use null-aware operator
      'gift': gift,
      'products': products!.map((product) => product.toJson()).toList(),// Handle null
    };
  }
}

class Address {
  int id;
  String name;
  String phone;
  String area;
  String flatNo;
  String addressType;
  String addressLine;
  String addressLine2;
  String postCode;
  bool isDefault;
  String? longitude;
  String? latitude;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.area,
    required this.flatNo,
    required this.addressType,
    required this.addressLine,
    required this.addressLine2,
    required this.postCode,
    required this.isDefault,
    this.longitude,
    this.latitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      area: json['area'],
      flatNo: json['flat_no'],
      addressType: json['address_type'],
      addressLine: json['address_line'],
      addressLine2: json['address_line2'],
      postCode: json['post_code'],
      isDefault: json['is_default'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'area': area,
      'flat_no': flatNo,
      'address_type': addressType,
      'address_line': addressLine,
      'address_line2': addressLine2,
      'post_code': postCode,
      'is_default': isDefault,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
