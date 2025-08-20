class VendorStatusModel {
  String? status;
  Data? data;
  VendorStatusModel({this.status, this.data});
  VendorStatusModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? vendorData;
  String? kycStatus;
  String? vendorStatus;
  String? kycRejectionReason;

  Data(
      {this.id,
        this.vendorData,
        this.kycStatus,
        this.vendorStatus,
        this.kycRejectionReason});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorData = json['vendor_data'];
    kycStatus = json['kyc_status'];
    vendorStatus = json['vendor_status'];
    kycRejectionReason = json['kyc_rejection_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_data'] = this.vendorData;
    data['kyc_status'] = this.kycStatus;
    data['vendor_status'] = this.vendorStatus;
    data['kyc_rejection_reason'] = this.kycRejectionReason;
    return data;
  }
}
