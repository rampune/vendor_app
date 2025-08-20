class AdsModel {
  String? duration;
  String? promotion_type;
  String? start_date;
  String? name;
  String? vendorId;

  AdsModel({
    this.duration,
    this.promotion_type,
    this.start_date,
    this.name,
    this.vendorId,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      duration: json['duration'] as String?,
      promotion_type: json['promotion_type'] as String?,
      start_date: json['start_date'] as String?,
      name: json['name'] as String?,
      vendorId: json['vendor_data'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'promotion_type': promotion_type,
      'start_date': start_date,
      'name': name,
      'vendor_data': vendorId,
    };
  }
}
