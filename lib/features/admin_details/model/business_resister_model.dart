class BusinessRegisterModel {
  String? status;
  String? message;
  BusinessData? businessData;

  BusinessRegisterModel({this.status, this.message, this.businessData});

  BusinessRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    businessData = json['data'] != null ? new BusinessData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? status;

  BusinessData(
      {this.id,
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
        this.status});

  BusinessData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    businessType = json['business_type'];
    businessRegistrationName = json['business_registration_name'];
    constitution = json['constitution'];
    email = json['email'];
    phoneNo = json['phone_no'];
    website = json['website'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pin_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    return data;
  }
}
