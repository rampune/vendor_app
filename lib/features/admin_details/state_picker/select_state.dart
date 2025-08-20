import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_pubup_partner/utils/string_to_int.dart';
import '../widget/custom_drop_down/custom_drop_down.dart' show CustomDropDownModel, CustomDropDown;
import 'model/state_model.dart';
class  SelectState extends StatefulWidget {
  const  SelectState({super.key,required this.callBack,required this.controller,
  this.validator});
  final Function(String) callBack;
  final TextEditingController controller ;
  final String? Function(String?) ?validator;

  @override
  State<SelectState> createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {

  List<CustomDropDownModel > ?stateList;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(future: listState(),
        builder: (BuildContext context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return CustomDropDown(
              validator: widget.validator,
              title: "State",
              heading:  "Select State",
              onSelect: (CustomDropDownModel selectedItem){
                widget.callBack('${selectedItem.id}');
              },
              controller: widget.controller,
              listCustomDropDownModel: snapshot.data?.map((item)=>CustomDropDownModel(name: item.name,id: stringToInt(item.id))).toList()??[],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        });
  }


  Future<List<StateModel>> listState()async{
    var jsonString = await rootBundle
        .loadString("assets/state.json");
    List<dynamic> listState=jsonDecode(jsonString);
    List<StateModel> listStateModel=[];
    for(int i=0;i<listState.length;i++){
      listStateModel.add(StateModel.fromJson(listState[i]));
    }
    return listStateModel;
  }
}
