class VendorIdModel {
  String? status;
  Data? data;

  VendorIdModel({this.status, this.data});

  VendorIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? vendorId;
  String? email;
  String? phoneNo;

  Data({this.vendorId, this.email, this.phoneNo});

  Data.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['vendor_id'] = vendorId;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    return data;
  }
}
