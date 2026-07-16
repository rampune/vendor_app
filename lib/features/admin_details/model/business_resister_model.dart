import 'dart:convert';

class BusinessRegisterModel {
  String? status;
  String? message;
  BusinessData? businessData;

  BusinessRegisterModel({this.status, this.message, this.businessData});

  BusinessRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    businessData =
        json['data'] != null ? BusinessData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.businessData != null) {
      data['data'] = this.businessData!.toJson();
    }
    return data;
  }
}

class BusinessData {
  int? id;
  String? vendorId;
  String? businessType;
  String? businessRegistrationName;
  String? constitution;
  String? email;
  String? phoneNo;
  String? website;
  int? approxPrice;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? status;
  String? deviceToken;

  // ── New fields ──────────────────────────────────────────────────────────────
  String? latitude;
  String? longitude;
  List<String> featuresFacilities;
  List<String> uniques;
  String? foodType;
  String? pubCafeFineDinningDescription;
  String? pubCafeFineDinningName;
  bool? isPubPause;

  BusinessData({
    this.id,
    this.vendorId,
    this.businessType,
    this.businessRegistrationName,
    this.constitution,
    this.email,
    this.phoneNo,
    this.website,
    this.approxPrice,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.status,
    this.deviceToken,
    this.latitude,
    this.longitude,
    this.foodType,
    this.pubCafeFineDinningDescription,
    this.pubCafeFineDinningName,
    this.isPubPause,
    List<String>? featuresFacilities,
    List<String>? uniques,
  })  : featuresFacilities = featuresFacilities ?? [],
        uniques = uniques ?? [];



  BusinessData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        vendorId = json['vendor_id'],
        businessType = json['business_type'],
        businessRegistrationName = json['business_registration_name'],
        constitution = json['constitution'],
        email = json['email'],
        phoneNo = json['phone_no'],
        website = json['website'],
        approxPrice = json['approx_price'],
        address = json['address'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        pinCode = json['pin_code'],
        status = json['status'],
        deviceToken = json['device_token'],
        latitude = json['latitude']?.toString(),
        longitude = json['longitude']?.toString(),
        featuresFacilities = _parseList(json['features_facilities']),
        foodType = json['food_type'],
        pubCafeFineDinningDescription = json['pub_cafe_fine_dinning_description'] ?? json['vendor_details']?['pub_cafe_fine_dinning_description'],
        pubCafeFineDinningName = json['pub_cafe_fine_dinning_name'] ?? json['vendor_details']?['pub_cafe_fine_dinning_name'],
        isPubPause = _parseIsPubPause(json),
        uniques = _parseList(json['uniques']);


  static List<String> _parseList(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    if (raw is String && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) return decoded.map((e) => e.toString()).toList();
      } catch (_) {}
    }
    return [];
  }

  static bool? _parseIsPubPause(Map<String, dynamic> json) {
    if (json.containsKey('isPubPause') && json['isPubPause'] != null) {
      final val = json['isPubPause'];
      if (val is bool) return val;
      if (val is String) return val.toLowerCase() == 'true';
    }
    if (json['vendor_details'] != null && json['vendor_details'] is Map) {
      final details = json['vendor_details'];
      if (details.containsKey('isPubPause') && details['isPubPause'] != null) {
        final val = details['isPubPause'];
        if (val is bool) return val;
        if (val is String) return val.toLowerCase() == 'true';
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['business_type'] = this.businessType;
    data['business_registration_name'] = this.businessRegistrationName;
    data['constitution'] = this.constitution;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['website'] = this.website;
    data['approx_price'] = this.approxPrice;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['status'] = this.status;
    data['device_token'] = this.deviceToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['features_facilities'] = this.featuresFacilities;
    data['uniques'] = this.uniques;
    data['food_type'] = this.foodType;
    data['pub_cafe_fine_dinning_description'] = this.pubCafeFineDinningDescription;
    data['pub_cafe_fine_dinning_name'] = this.pubCafeFineDinningName;
    data['isPubPause'] = this.isPubPause;
    return data;
  }
}
