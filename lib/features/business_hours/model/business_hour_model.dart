
class BusinessHourData {
  int? id;
  String? vendorData;
  List<OperationalTime>? operationalTime;
  List<OperationalDate>? operationalDate;

  BusinessHourData({this.id, this.vendorData, this.operationalTime, this.operationalDate});

  BusinessHourData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorData = json['vendor_data'];
    if (json['operational_time'] != null) {
      operationalTime = <OperationalTime>[];
      json['operational_time'].forEach((v) {
        operationalTime!.add(new OperationalTime.fromJson(v));
      });
    }
    if (json['operational_date'] != null) {
      operationalDate = <OperationalDate>[];
      json['operational_date'].forEach((v) {
        operationalDate!.add(new OperationalDate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_data'] = this.vendorData;
    if (this.operationalTime != null) {
      data['operational_time'] =
          this.operationalTime!.map((v) => v.toJson()).toList();
    }
    if (this.operationalDate != null) {
      data['operational_date'] =
          this.operationalDate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OperationalTime {
  String? day;
  bool? isopen;
  // List<Slot>? slot;
  String? slot;

  OperationalTime({this.day, this.isopen, this.slot});

  OperationalTime.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    isopen = json['isopen'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['isopen'] = this.isopen;

    data['slot'] = this.slot;
    return data;
  }
}

class OperationalDate {
  String? date;
  bool? isopen;
  String? slot;

  OperationalDate({this.date, this.isopen, this.slot});

  OperationalDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isopen = json['isopen'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['isopen'] = this.isopen;
    data['slot'] = this.slot;
    return data;
  }
}
