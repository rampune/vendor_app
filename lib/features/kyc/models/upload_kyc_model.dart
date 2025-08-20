class UploadKycModel {
  String? businessRegistrationProof;
  String? gstCertificate;
  String? panCard;
  String? fssaiLicense;

  UploadKycModel({
    this.businessRegistrationProof,
    this.gstCertificate,
    this.panCard,
    this.fssaiLicense,
  });

  // Factory constructor to create object from JSON
  factory UploadKycModel.fromJson(Map<String, dynamic> json) {
    return UploadKycModel(
      businessRegistrationProof: json['businessRegistrationProof'] as String?,
      gstCertificate: json['gstCertificate'] as String?,
      panCard: json['panCard'] as String?,
      fssaiLicense: json['fssaiLicense'] as String?,
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'businessRegistrationProof': businessRegistrationProof,
      'gstCertificate': gstCertificate,
      'panCard': panCard,
      'fssaiLicense': fssaiLicense,
    };
  }
}
