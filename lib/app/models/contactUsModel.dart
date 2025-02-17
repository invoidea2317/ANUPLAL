class ContactInfo {
  final String phone;
  final String email;

  ContactInfo({required this.phone, required this.email});

  // Factory method to create a ContactInfo instance from a JSON map
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'] as String,
      email: json['email'] as String,
    );
  }

  // Method to convert a ContactInfo instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
    };
  }
}
