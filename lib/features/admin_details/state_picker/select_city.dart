
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_pubup_partner/utils/string_to_int.dart';
import '../widget/custom_drop_down/custom_drop_down.dart';
import 'model/city_model.dart';

class  SelectCity extends StatefulWidget {
  const  SelectCity({super.key, required this.stateId,required this.callBack,required this.controller,
  this.validator});
final String stateId;
final TextEditingController controller;
final Function(String) callBack;
final String? Function(String?) ?validator;
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {

  List<CustomDropDownModel > ?stateList;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: listCity(stateId: widget.stateId),
        builder: (BuildContext context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return CustomDropDown(
              validator: widget.validator,
              onSelect: (CustomDropDownModel selectedItem){
                widget.callBack('${selectedItem.id}');
              },
              title: "City",
              heading: "Select City",
              controller: widget.controller, listCustomDropDownModel: snapshot.data?.map((item)=>CustomDropDownModel(name: item.name,id: stringToInt(item.id))).toList()??[],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        });
  }


  Future<List<CityModel>> 
  listCity({required String stateId})async{
    var jsonString = await rootBundle
        .loadString("assets/city.json");
    List<dynamic> listState=jsonDecode(jsonString);
    List<CityModel> listCityModel=[];
    
    for(int i=0;i<listState.length;i++){
      if(listState[i]["state_id"]==stateId){
        listCityModel.add(CityModel.fromJson(listState[i]));
      }
      
    }
    return listCityModel;
  }
}
