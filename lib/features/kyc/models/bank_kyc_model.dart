class BankKycModel {
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? checkImageUrl;
  BankKycModel({
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.ifscCode,
    this.checkImageUrl,
  });
  factory BankKycModel.fromJson(Map<String, dynamic> json) {
    return BankKycModel(
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      ifscCode: json['ifscCode'],
      checkImageUrl: json['checkImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'ifscCode': ifscCode,
      'checkImageUrl': checkImageUrl,
    };
  }
}