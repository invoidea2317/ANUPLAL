class CropDoctorModel {
  final int? whatsappNumber;
  final int? expertMobileNumber;

  CropDoctorModel({
    this.whatsappNumber,
    this.expertMobileNumber,
  });

  /// Factory constructor for creating a new instance from JSON
  factory CropDoctorModel.fromJson(Map<String, dynamic> json) {
    return CropDoctorModel(
      whatsappNumber: json['whatsapp_number'] as int?,
      expertMobileNumber: json['expert_mobile_number'] as int?,
    );
  }

  /// Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'whatsapp_number': whatsappNumber,
      'expert_mobile_number': expertMobileNumber,
    };
  }
}