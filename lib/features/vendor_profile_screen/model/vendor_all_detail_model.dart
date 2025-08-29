
// pub_cafe_all_details_model.dart
class VendorAllDetailsResponse {
  String? status;
  PubCafeVendorModel? data;

  VendorAllDetailsResponse({this.status, this.data});

  factory VendorAllDetailsResponse.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Debug the input
    return VendorAllDetailsResponse(
      status: json['status'] as String?,
      data: json['data'] != null ? PubCafeVendorModel.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PubCafeVendorModel {
  final int? id;
  final dynamic vendorDetails; // Can be null or VendorDetailsModel
  final dynamic vendorStatus; // Can be null or VendorStatusModel
  final dynamic vendorDeviceTokens; // Typically null
  final String? vendorId;
  final String? businessType;
  final String? businessRegistrationName;
  final String? constitution;
  final String? email;
  final String? phoneNo;
  final String? website;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;
  final String? status;
  final dynamic deviceToken; // Typically null

  PubCafeVendorModel({
    this.id,
    this.vendorDetails,
    this.vendorStatus,
    this.vendorDeviceTokens,
    this.vendorId,
    this.businessType,
    this.businessRegistrationName,
    this.constitution,
    this.email,
    this.phoneNo,
    this.website,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.status,
    this.deviceToken,
  });

  factory PubCafeVendorModel.fromJson(Map<String, dynamic> json) {
    print('Parsing Vendor JSON: $json'); // Debug the input
    return PubCafeVendorModel(
      id: json['id'] as int?,
      vendorDetails: json['vendor_details'] != null
          ? VendorDetailsModel.fromJson(json['vendor_details'] as Map<String, dynamic>)
          : null,
      vendorStatus: json['vendor_status'] != null
          ? VendorStatusModel.fromJson(json['vendor_status'] as Map<String, dynamic>)
          : null,
      vendorDeviceTokens: json['vendor_device_tokens'],
      vendorId: json['vendor_id'] as String?,
      businessType: json['business_type'] as String?,
      businessRegistrationName: json['business_registration_name'] as String?,
      constitution: json['constitution'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phone_no'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pinCode: json['pin_code'] as String?,
      status: json['status'] as String?,
      deviceToken: json['device_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.vendorDetails != null) data['vendor_details'] = (this.vendorDetails as VendorDetailsModel).toJson();
    if (this.vendorStatus != null) data['vendor_status'] = (this.vendorStatus as VendorStatusModel).toJson();
    data['vendor_device_tokens'] = this.vendorDeviceTokens;
    data['vendor_id'] = this.vendorId;
    data['business_type'] = this.businessType;
    data['business_registration_name'] = this.businessRegistrationName;
    data['constitution'] = this.constitution;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['website'] = this.website;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['status'] = this.status;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

class VendorDetailsModel {
  final int? id;
  final String? pubCafeFineDinningName;
  final String? pubCafeFineDinningDescription;
  final String? businessRegistrationName;
  final String? constitution;
  final String? gstIn;
  final String? panCardNumber;
  final String? fssaiLicenseNumber;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final String? ifscCode;
  final String? cancelledCheque;
  final String? ownerName;
  final String? ownerEmail;
  final String? ownerContact;
  final String? logo;
  final String? businessPhoto;
  final String? businessRegistrationProof;
  final String? gstCertificate;
  final String? panCardFile;
  final String? fssaiLicenseFile;
  final String? kycStatus;
  final String? kycRejectionReason;
  final int? vendorData;

  VendorDetailsModel({
    this.id,
    this.pubCafeFineDinningName,
    this.pubCafeFineDinningDescription,
    this.businessRegistrationName,
    this.constitution,
    this.gstIn,
    this.panCardNumber,
    this.fssaiLicenseNumber,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.ifscCode,
    this.cancelledCheque,
    this.ownerName,
    this.ownerEmail,
    this.ownerContact,
    this.logo,
    this.businessPhoto,
    this.businessRegistrationProof,
    this.gstCertificate,
    this.panCardFile,
    this.fssaiLicenseFile,
    this.kycStatus,
    this.kycRejectionReason,
    this.vendorData,
  });

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) {
    print('Parsing VendorDetails JSON: $json'); // Debug the input
    return VendorDetailsModel(
      id: json['id'] as int?,
      pubCafeFineDinningName: json['pub_cafe_fine_dinning_name'] as String?,
      pubCafeFineDinningDescription: json['pub_cafe_fine_dinning_description'] as String?,
      businessRegistrationName: json['business_registration_name'] as String?,
      constitution: json['constitution'] as String?,
      gstIn: json['gst_in'] as String?,
      panCardNumber: json['pan_card_number'] as String?,
      fssaiLicenseNumber: json['fssai_license_number'] as String?,
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      cancelledCheque: json['cancelled_cheque'] as String?,
      ownerName: json['owner_name'] as String?,
      ownerEmail: json['owner_email'] as String?,
      ownerContact: json['owner_contact'] as String?,
      logo: json['logo'] as String?,
      businessPhoto: json['business_photo'] as String?,
      businessRegistrationProof: json['business_registration_proof'] as String?,
      gstCertificate: json['gst_certificate'] as String?,
      panCardFile: json['pan_card_file'] as String?,
      fssaiLicenseFile: json['fssai_license_file'] as String?,
      kycStatus: json['kyc_status'] as String?,
      kycRejectionReason: json['kyc_rejection_reason'] as String?,
      vendorData: json['vendor_data'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['pub_cafe_fine_dinning_name'] = this.pubCafeFineDinningName;
    data['pub_cafe_fine_dinning_description'] = this.pubCafeFineDinningDescription;
    data['business_registration_name'] = this.businessRegistrationName;
    data['constitution'] = this.constitution;
    data['gst_in'] = this.gstIn;
    data['pan_card_number'] = this.panCardNumber;
    data['fssai_license_number'] = this.fssaiLicenseNumber;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['cancelled_cheque'] = this.cancelledCheque;
    data['owner_name'] = this.ownerName;
    data['owner_email'] = this.ownerEmail;
    data['owner_contact'] = this.ownerContact;
    data['logo'] = this.logo;
    data['business_photo'] = this.businessPhoto;
    data['business_registration_proof'] = this.businessRegistrationProof;
    data['gst_certificate'] = this.gstCertificate;
    data['pan_card_file'] = this.panCardFile;
    data['fssai_license_file'] = this.fssaiLicenseFile;
    data['kyc_status'] = this.kycStatus;
    data['kyc_rejection_reason'] = this.kycRejectionReason;
    data['vendor_data'] = this.vendorData;
    return data;
  }
}

class VendorStatusModel {
  final int? id;
  final String? kycStatus;
  final String? vendorStatus;
  final String? kycRejectionReason;
  final int? vendorData;

  VendorStatusModel({
    this.id,
    this.kycStatus,
    this.vendorStatus,
    this.kycRejectionReason,
    this.vendorData,
  });

  factory VendorStatusModel.fromJson(Map<String, dynamic> json) {
    print('Parsing VendorStatus JSON: $json'); // Debug the input
    return VendorStatusModel(
      id: json['id'] as int?,
      kycStatus: json['kyc_status'] as String?,
      vendorStatus: json['vendor_status'] as String?,
      kycRejectionReason: json['kyc_rejection_reason'] as String?,
      vendorData: json['vendor_data'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['kyc_status'] = this.kycStatus;
    data['vendor_status'] = this.vendorStatus;
    data['kyc_rejection_reason'] = this.kycRejectionReason;
    data['vendor_data'] = this.vendorData;
    return data;
  }
}
