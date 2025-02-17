class User {
  int id;
  String name;
  String phone;
  bool phoneVerified;
  String? email;
  bool emailVerified;
  bool isActive;
  String profilePhoto;
  String? gender;
  String dateOfBirth;
  String? country;
  String? latitude;
  String? longitude;
  String? phoneCode;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.phoneVerified,
    this.email,
    required this.emailVerified,
    required this.isActive,
    required this.profilePhoto,
    this.gender,
    required this.dateOfBirth,
    this.country,
    this.phoneCode,
    this.latitude,
    this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? "",
      phone: json['phone'],
      phoneVerified: json['phone_verified'],
      email: json['email'],
      emailVerified: json['email_verified'],
      isActive: json['is_active'],
      profilePhoto: json['profile_photo'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'] ?? "",
      country: json['country'],
      phoneCode: json['phone_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'phone_verified': phoneVerified,
      'email': email,
      'email_verified': emailVerified,
      'is_active': isActive,
      'profile_photo': profilePhoto,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'country': country,
      'phone_code': phoneCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
