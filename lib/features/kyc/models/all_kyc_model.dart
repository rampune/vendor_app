class AllKycModel {
  String? vendorData;
  String? pubCafeFineDinningName;
  String? businessRegistrationName;
  String? constitution;
  String? gstIn;
  String? panCardNumber;
  String? fssaiLicenseNumber;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? ifscCode;

  String? ownerName;
  String? ownerEmail;
  String? ownerContact;




  AllKycModel(
      {this.vendorData,
        this.pubCafeFineDinningName,
        this.businessRegistrationName,
        this.constitution,
        this.gstIn,
        this.panCardNumber,
        this.fssaiLicenseNumber,
        this.bankName,
        this.accountName,
        this.accountNumber,
        this.ifscCode,

        this.ownerName,
        this.ownerEmail,
        this.ownerContact,




     });

  AllKycModel.fromJson(Map<String, dynamic> json) {
    vendorData = json['vendor_data'];
    pubCafeFineDinningName = json['pub_cafe_fine_dinning_name'];
    businessRegistrationName = json['business_registration_name'];
    constitution = json['constitution'];
    gstIn = json['gst_in'];
    panCardNumber = json['pan_card_number'];
    fssaiLicenseNumber = json['fssai_license_number'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];

    ownerName = json['owner_name'];
    ownerEmail = json['owner_email'];
    ownerContact = json['owner_contact'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_data'] = this.vendorData;
    data['pub_cafe_fine_dinning_name'] = this.pubCafeFineDinningName;
    data['business_registration_name'] = this.businessRegistrationName;
    data['constitution'] = this.constitution;
    data['gst_in'] = this.gstIn;
    data['pan_card_number'] = this.panCardNumber;
    data['fssai_license_number'] = this.fssaiLicenseNumber;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;

    data['owner_name'] = this.ownerName;
    data['owner_email'] = this.ownerEmail;
    data['owner_contact'] = this.ownerContact;

    return data;
  }
}
