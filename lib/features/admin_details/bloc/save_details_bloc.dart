import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import '../../../data/source/network/api_result_handler.dart';
import '../model/business_resister_model.dart';
import '../repository/save_repository.dart';
class SaveDetailsBloc extends Bloc<SaveDetailsEvent,SaveDetailsState>{
  SaveDetailsBloc():super(SaveInitState()){
    on(handler);
  }
  handler(SaveDetailsEvent event,Emitter<SaveDetailsState> emit)async{


if(event is SaveBusinessDetailsEvent){
  emit(SaveLoadingState());
try {
  ApiResults ? results = await SaveRepository.instance.patchBusinessDetails(
      mapData: event.businessData.toJson()..removeWhere((key, value) => value == null),vendorId:event.vendorId );
  print("${results?.data}  ${results?.statusCode}");
  if(results?.statusCode==200||results?.statusCode==201){
    BusinessProfileData.saveBusinessRegistrationData(BusinessRegisterModel.fromJson(results?.data));
emit(SaveBusinessDetailAlreadyFillState());
  }else{
    emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
  }

}catch(exception){
  emit(SaveErrorState(errorMsg: "$exception"));
}
}


else if(event is SaveBusinessDetailsPatchFieldEvent){

  emit(SaveLoadingState());
  try {
    ApiResults ? results = await SaveRepository.instance.patchBusinessDetails(
        mapData:event.mapData,vendorId:event.vendorId );
    print("${results?.data}  ${results?.statusCode}");
    if(results?.statusCode==200||results?.statusCode==201){
      BusinessProfileData.saveBusinessRegistrationData(BusinessRegisterModel.fromJson(results?.data));
      emit(SaveBusinessDetailAlreadyFillState());
    }else{
      emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
    }

  }catch(exception){
    emit(SaveErrorState(errorMsg: "$exception"));
  }
}




else if (event is GetBusinessDetailsEvent){
  emit(SaveLoadingState());


    ApiResults ? results = await SaveRepository.instance.saveBusinessDetails(
        mapData:{event.emailOrPhone.contains("@")?"email":"phone_no":event.emailOrPhone});
    print("${results?.data}  ${results?.statusCode}");
    if(results?.statusCode==200||(results?.statusCode==201)){
      BusinessRegisterModel businessRegisterModel=BusinessRegisterModel.fromJson(results?.data);

      if(businessRegisterModel.businessData?.businessRegistrationName!=null){
        BusinessProfileData.saveBusinessRegistrationData(businessRegisterModel);
        emit(SaveBusinessDetailAlreadyFillState());
      }else{
        emit(SaveDetailsFreshUserSuccessState(businessRegisterModel: businessRegisterModel));
      }

    }else{
      emit(SaveErrorState(errorMsg: "${results?.data}  ${results?.message}"));
    }


}
  }
}




abstract class SaveDetailsEvent{}
class SaveBusinessDetailsEvent extends SaveDetailsEvent{
  final BusinessData businessData;
  final String vendorId;
  SaveBusinessDetailsEvent({required this.businessData,required this.vendorId});
}

class SaveBusinessDetailsPatchFieldEvent extends SaveDetailsEvent{
  final Map<String,dynamic> mapData;
  final String vendorId;
  SaveBusinessDetailsPatchFieldEvent({required this.mapData,
    required this.vendorId});
}

class GetBusinessDetailsEvent extends SaveDetailsEvent{
  final String emailOrPhone;
  GetBusinessDetailsEvent
      ({required this.emailOrPhone});
}
abstract class SaveDetailsState extends Equatable{}
 class SaveInitState extends SaveDetailsState{
  @override
  List<Object?> get props => [];
 }

class SaveLoadingState extends SaveDetailsState{
  @override
  List<Object?> get props => [];
}
class SaveBusinessDetailAlreadyFillState extends SaveDetailsState{

  SaveBusinessDetailAlreadyFillState();
  @override
  List<Object?> get props => [];
}
class SaveDetailsFreshUserSuccessState extends SaveDetailsState{
 final  BusinessRegisterModel businessRegisterModel;
  SaveDetailsFreshUserSuccessState({required this.businessRegisterModel});
  @override
  List<Object?> get props => [];
}
class SaveErrorState extends SaveDetailsState{
  final String errorMsg;
  SaveErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}