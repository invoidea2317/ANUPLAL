import 'package:anuplal/app/models/profile_model.dart';

class CommunityResponse {
  final String message;
  final CommunityData data;

  CommunityResponse({
    required this.message,
    required this.data,
  });

  factory CommunityResponse.fromJson(Map<String, dynamic> json) {
    return CommunityResponse(
      message: json['message'],
      data: CommunityData.fromJson(json['data']),
    );
  }
}

class CommunityData {
  final CommunityDetails community;

  CommunityData({
    required this.community,
  });

  factory CommunityData.fromJson(Map<String, dynamic> json) {
    return CommunityData(
      community: CommunityDetails.fromJson(json['comunity']),
    );
  }
}

class CommunityDetails {
  final int currentPage;
  final List<CommunityItem> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  CommunityDetails({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CommunityDetails.fromJson(Map<String, dynamic> json) {
    return CommunityDetails(
      currentPage: json['current_page'],
      data: (json['data'] as List)
          .map((item) => CommunityItem.fromJson(item))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'] ?? 0,
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List)
          .map((link) => PageLink.fromJson(link))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'],
    );
  }
}

class CommunityItem {
  final int id;
  final int userId;
  final String title;
  final int mediaId;
  final CommunityUser? user;
  final String description;
  final String createdAt;
  final String updatedAt;
  final Media? media;

  CommunityItem({
    required this.id,
    required this.user,
    required this.userId,
    required this.title,
    required this.mediaId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.media,
  });

  factory CommunityItem.fromJson(Map<String, dynamic> json) {
    return CommunityItem(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      mediaId: json['media_id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
      user: json['user'] != null ? CommunityUser.fromJson(json['user']) : null,
    );
  }
}

class Media {
  final int id;
  final String type;
  final String name;
  final String? originalName;
  final String src;
  final String? extention;
  final String createdAt;
  final String updatedAt;

  Media({
    required this.id,
    required this.type,
    required this.name,
    this.originalName,
    required this.src,
    this.extention,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      type: json['type']??"",
      name: json['name']??"",
      originalName: json['original_name']??"",
      src: json['src']??"",
      extention: json['extention']??"",
      createdAt: json['created_at']??"",
      updatedAt: json['updated_at']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'original_name': originalName,
      'src': src,
      'extention': extention,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

class CommunityUser {
  final int id;
  final String name;
  final String? lastName;
  final String? phone;
  final String email;
  final int mediaId;
  final String gender;
  final String dateOfBirth;
  final int isActive;
  final DateTime emailVerifiedAt;
  final DateTime phoneVerifiedAt;
  final String? drivingLicence;
  final String? vehicleType;
  final int registerStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final UserMedia? media;

  CommunityUser({
    required this.id,
    required this.name,
    this.lastName,
    required this.phone,
    required this.email,
    required this.mediaId,
    required this.gender,
    required this.dateOfBirth,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.phoneVerifiedAt,
    this.drivingLicence,
    this.vehicleType,
    required this.registerStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.media,
  });

  factory CommunityUser.fromJson(Map<String, dynamic> json) {
    return CommunityUser(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email']??"",
      mediaId: json['media_id']??0,
      gender: json['gender']??"",
      dateOfBirth: json['date_of_birth']??"",
      isActive: json['is_active']??0,
      emailVerifiedAt: DateTime.parse(json['email_verified_at']??"2024-11-25T05:07:45.000000Z"),
      phoneVerifiedAt: DateTime.parse(json['phone_verified_at']??"2024-11-25T05:07:45.000000Z"),
      drivingLicence: json['driving_lience'],
      vehicleType: json['vehicle_type'],
      registerStatus: json['register_status']??0,
      createdAt: DateTime.parse(json['created_at']??"2024-11-25T05:07:45.000000Z"),
      updatedAt: DateTime.parse(json['updated_at']??"2024-11-25T05:07:45.000000Z"),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      media: json['media'] != null ? UserMedia.fromJson(json['media']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'media_id': mediaId,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'is_active': isActive,
      'email_verified_at': emailVerifiedAt.toIso8601String(),
      'phone_verified_at': phoneVerifiedAt.toIso8601String(),
      'driving_lience': drivingLicence,
      'vehicle_type': vehicleType,
      'register_status': registerStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'media': media?.toJson(),
    };
  }
}

class UserMedia {
  final int id;
  final String type;
  final String name;
  final String? originalName;
  final String src;
  final String extention;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserMedia({
    required this.id,
    required this.type,
    required this.name,
    this.originalName,
    required this.src,
    required this.extention,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserMedia.fromJson(Map<String, dynamic> json) {
    return UserMedia(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      originalName: json['original_name'],
      src: json['src'],
      extention: json['extention'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'original_name': originalName,
      'src': src,
      'extention': extention,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}