import 'package:flutter/cupertino.dart';

class SlotModel{
  String ? startTime,endTime,slotName;

  SlotModel({this.endTime,this.startTime,this.slotName});
  factory SlotModel.fromJson(Map<String,dynamic> data){
    return SlotModel(
      startTime: data["start_time"],
      endTime: data["end_time"],
      slotName: data["slot_name"]

    );
  }

  toJson(){
    return {
      "start_time":startTime,
      "end_time":endTime,
      "slot_name":slotName

    };

  }


}