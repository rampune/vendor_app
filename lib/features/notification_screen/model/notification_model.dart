// lib/features/notifications/models/notification_model.dart

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final VendorData? vendorData;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.vendorData,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      vendorData: json['vendor_data'] != null
          ? VendorData.fromJson(json['vendor_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'created_at': createdAt.toIso8601String(),
      'vendor_data': vendorData?.toJson(),
    };
  }
}

class VendorData {
  final int id;
  final String vendorId;
  final String email;
  final String phoneNo;

  VendorData({
    required this.id,
    required this.vendorId,
    required this.email,
    required this.phoneNo,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['id'] ?? 0,
      vendorId: json['vendor_id'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phone_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'email': email,
      'phone_no': phoneNo,
    };
  }
}