class PromotionModel {
  String? status;
  List<PromotionDataModel>? promotionDataModel;

  PromotionModel({this.status, this.promotionDataModel});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      promotionDataModel = <PromotionDataModel>[];
      json['data'].forEach((v) {
        promotionDataModel!.add(new PromotionDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.promotionDataModel != null) {
      data['data'] = this.promotionDataModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromotionDataModel {
  int? id;
  String? vendorData;
  String? image;
  String? btnName;
  bool? status;
  String? name;
  String? duration;
  String? promotionType;
  String? startDate;

  PromotionDataModel(
      {this.id,
        this.vendorData,
        this.image,
        this.btnName,
        this.status,
        this.name,
        this.duration,
        this.promotionType,
        this.startDate});

  PromotionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorData = json['vendor_data'];
    image = json['image'];
    btnName = json['btn_name'];
    status = json['status'];
    name = json['name'];
    duration = json['duration'];
    promotionType = json['event_type'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_data'] = this.vendorData;
    data['image'] = this.image;
    data['btn_name'] = this.btnName;
    data['status'] = this.status;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['event_type'] = this.promotionType;
    data['start_date'] = this.startDate;
    return data;
  }
}
