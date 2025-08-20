import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';

import '../../../../config/string.dart' show AppStr;
import '../../../../features/kyc/models/bank_kyc_model.dart';
import '../../../../features/kyc/models/business_kyc_model.dart';
import '../../../../features/kyc/models/owner_details_kyc_model.dart';
import '../../../../features/kyc/models/upload_kyc_model.dart';
import '../hive_box.dart';

class HiveBloc extends Bloc<HiveEvent,HiveState>{
  HiveBloc():super(HiveInitState()){
    on(handler);
  }
}
handler(HiveEvent event,Emitter<HiveState> emit){
  if(event is HiveSaveBusinessKycEvent){
    try{
      emit(HiveLoadingState());
      String data=jsonEncode(event.businessKycModel.toJson());
      print("amra007$data");
      MyHiveBox.instance.getBox().put(AppStr.businessKyc, data);
      emit(HiveSuccessState());
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }

  }else if(event is HiveSaveUploadKycEvent){

    try{
      emit(HiveLoadingState());
      String data=jsonEncode(event.uploadKycModel.toJson());
      print("amra007$data");
      MyHiveBox.instance.getBox().put(AppStr.uploadKyc, data);
      emit(HiveSuccessState());
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }

  }else if(event is HiveGetUploadKycEvent){
    emit(HiveLoadingState());
    try{
      String ? data=MyHiveBox.instance.getBox().get(AppStr.uploadKyc,defaultValue: null);

      print("amra007${data}");
      UploadKycModel model=UploadKycModel.fromJson(jsonDecode(data??''));
      emit(HiveGetUploadKycState(uploadKycModel: model));
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }

  }else if(event is HiveSaveBusinessRegistrationEvent){
    try{
      emit(HiveLoadingState());
      String data=jsonEncode(event.businessRegisterModel.toJson());
      print("amra007$data");
      MyHiveBox.instance.getBox().put(AppStr.businessRegistration, data);
      emit(HiveSuccessState());
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }
  }else if(event is HiveGetBusinessRegistrationEvent){
    emit(HiveLoadingState());
    try{
      String ? data=MyHiveBox.instance.getBox().get(AppStr.businessRegistration,defaultValue: null);

      print("amra007${data}");
      BusinessRegisterModel model=BusinessRegisterModel.fromJson(jsonDecode(data??''));
      emit(HiveGetBusinessRegistrationState(businessRegisterModel: model));
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }
  }


  else if(event is HiveSaveOwnerKycEvent){
      try{
        emit(HiveLoadingState());
        String data=jsonEncode(event.ownerKycModel.toJson());
        print("amra007$data");
        MyHiveBox.instance.getBox().put(AppStr.ownerKyc, data);
        emit(HiveSuccessState());
      }catch(exception){
        emit(HiveErrorState(errorMessage: "$exception"));
      }


  }else if(event is HiveGetOwnerKycEvent){

    emit(HiveLoadingState());
    try{
      String ? data=MyHiveBox.instance.getBox().get(AppStr.ownerKyc,defaultValue: null);

      print("amra007${data}");
      OwnerKycModel model=OwnerKycModel.fromJson(jsonDecode(data??''));
      emit(HiveGetOwnerKycState(ownerKycModel: model));
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }

  }

  else if(event is HiveGetBusinessKycEvent){
    emit(HiveLoadingState());
    try{
      String ? data=MyHiveBox.instance.getBox().get(AppStr.businessKyc,defaultValue: null);

   print("amra007${data}");
      BusinessKycModel model=BusinessKycModel.fromJson(jsonDecode(data??''));
      emit(HiveGetBusinessKycState(businessKycModel: model));
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }


  }else if(event is HiveSaveBankKycEvent){
    try{
      emit(HiveLoadingState());
      String data=jsonEncode(event.bankKycModel.toJson());
      MyHiveBox.instance.getBox().put(AppStr.bankKyc, data);
      emit(HiveSuccessState());
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }
  }else if(event is HiveGetBankKycEvent){
    emit(HiveLoadingState());
    try{
      String ? data=MyHiveBox.instance.getBox().get(AppStr.bankKyc,defaultValue: null);
      BankKycModel model=BankKycModel.fromJson(jsonDecode(data??''));
      emit(HiveGetBankKycState(bankKycModel: model));
    }catch(exception){
      emit(HiveErrorState(errorMessage: "$exception"));
    }
  }

}

abstract class HiveEvent{}
class HiveSaveBusinessKycEvent extends HiveEvent{
BusinessKycModel businessKycModel;
  HiveSaveBusinessKycEvent({required this.businessKycModel});
}
class HiveSaveUploadKycEvent extends HiveEvent{
  UploadKycModel uploadKycModel;
  HiveSaveUploadKycEvent({required this.uploadKycModel});
}
class HiveGetUploadKycEvent extends HiveEvent{

}



class HiveSaveBusinessRegistrationEvent extends HiveEvent{
  BusinessRegisterModel businessRegisterModel;
  HiveSaveBusinessRegistrationEvent({required this.businessRegisterModel});
}
class HiveGetBusinessRegistrationEvent extends HiveEvent{

}

class HiveSaveOwnerKycEvent extends HiveEvent{
  OwnerKycModel ownerKycModel;
  HiveSaveOwnerKycEvent({required this.ownerKycModel});
}
class HiveGetOwnerKycEvent extends HiveEvent{

  HiveGetOwnerKycEvent();
}
class HiveSaveBankKycEvent extends HiveEvent{
  BankKycModel bankKycModel;
  HiveSaveBankKycEvent({required this.bankKycModel});
}
class HiveGetBankKycEvent extends HiveEvent{

  HiveGetBankKycEvent();
}
class HiveGetBusinessKycEvent extends HiveEvent{

  HiveGetBusinessKycEvent();
}


abstract class HiveState extends Equatable{}
 class HiveInitState extends HiveState{
  @override
  List<Object?> get props => [];
 }
class HiveGetBusinessKycState extends HiveState{
 final  BusinessKycModel businessKycModel;
 HiveGetBusinessKycState({required this.businessKycModel});
  @override
  List<Object?> get props => [];
}
class HiveGetBankKycState extends HiveState{
  final  BankKycModel bankKycModel;
  HiveGetBankKycState({required this.bankKycModel});
  @override
  List<Object?> get props => [];
}
class HiveGetOwnerKycState extends HiveState{
  final  OwnerKycModel ownerKycModel;
  HiveGetOwnerKycState({required this.ownerKycModel});
  @override
  List<Object?> get props => [];
}
class HiveGetBusinessRegistrationState extends HiveState{
  final  BusinessRegisterModel businessRegisterModel;
  HiveGetBusinessRegistrationState({required this.businessRegisterModel});
  @override
  List<Object?> get props => [];
}
class HiveGetUploadKycState extends HiveState{
  final  UploadKycModel uploadKycModel;
  HiveGetUploadKycState({required this.uploadKycModel});
  @override
  List<Object?> get props => [];
}
class HiveSuccessState extends HiveState{
  @override
  List<Object?> get props => [];
}
class HiveLoadingState extends HiveState{
  @override
  List<Object?> get props => [];
}
class HiveErrorState extends HiveState{
  final String errorMessage;
  HiveErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
