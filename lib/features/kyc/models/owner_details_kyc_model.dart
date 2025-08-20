class OwnerKycModel {
  String? ownerName;
  String? ownerEmailId;
  String? ownerContactNumber;
  String? logoUrl;
  String? businessPhotoUrl;
  OwnerKycModel({
    this.ownerName,
    this.ownerEmailId,
    this.ownerContactNumber,
    this.logoUrl,
    this.businessPhotoUrl,
  });
  factory OwnerKycModel.fromJson(Map<String, dynamic> json) {
    return OwnerKycModel(
      ownerName: json['ownerName'],
      ownerEmailId: json['ownerEmailId'],
      ownerContactNumber: json['ownerContactNumber'],
      logoUrl: json['logoUrl'],
      businessPhotoUrl: json['businessPhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerName': ownerName,
      'ownerEmailId': ownerEmailId,
      'ownerContactNumber': ownerContactNumber,
      'logoUrl': logoUrl,
      'businessPhotoUrl': businessPhotoUrl,
    };
  }
}