// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
// import '../../../data/source/network/api_result_handler.dart';
// import '../model/business_resister_model.dart';
// import '../repository/save_repository.dart';
// class SaveDetailsBloc extends Bloc<SaveDetailsEvent,SaveDetailsState>{
//   SaveDetailsBloc():super(SaveInitState()){
//     on(handler);
//   }
//   handler(SaveDetailsEvent event,Emitter<SaveDetailsState> emit)async{
//
//
// if(event is SaveBusinessDetailsEvent){
//   emit(SaveLoadingState());
// try {
//   ApiResults ? results = await SaveRepository.instance.patchBusinessDetails(
//       mapData: event.businessData.toJson()..removeWhere((key, value) => value == null),vendorId:event.vendorId );
//   print("${results?.data}  ${results?.statusCode}");
//   if(results?.statusCode==200||results?.statusCode==201){
//     BusinessProfileData.saveBusinessRegistrationData(BusinessRegisterModel.fromJson(results?.data));
// emit(SaveBusinessDetailAlreadyFillState());
//   }else{
//     emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
//   }
//
// }catch(exception){
//   emit(SaveErrorState(errorMsg: "$exception"));
// }
// }
//
//
// else if(event is SaveBusinessDetailsPatchFieldEvent){
//
//   emit(SaveLoadingState());
//   try {
//     ApiResults ? results = await SaveRepository.instance.patchBusinessDetails(
//         mapData:event.mapData,vendorId:event.vendorId );
//     print("${results?.data}  ${results?.statusCode}");
//     if(results?.statusCode==200||results?.statusCode==201){
//       BusinessProfileData.saveBusinessRegistrationData(BusinessRegisterModel.fromJson(results?.data));
//       emit(SaveBusinessDetailAlreadyFillState());
//     }else{
//       emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
//     }
//
//   }catch(exception){
//     emit(SaveErrorState(errorMsg: "$exception"));
//   }
// }
//
//
//
//
// else if (event is GetBusinessDetailsEvent){
//   emit(SaveLoadingState());
//
//
//     ApiResults ? results = await SaveRepository.instance.saveBusinessDetails(
//         mapData:{event.emailOrPhone.contains("@")?"email":"phone_no":event.emailOrPhone});
//     print("${results?.data}  ${results?.statusCode}");
//     if(results?.statusCode==200||(results?.statusCode==201)){
//       BusinessRegisterModel businessRegisterModel=BusinessRegisterModel.fromJson(results?.data);
//
//       if(businessRegisterModel.businessData?.businessRegistrationName!=null){
//         BusinessProfileData.saveBusinessRegistrationData(businessRegisterModel);
//         emit(SaveBusinessDetailAlreadyFillState());
//       }else{
//         emit(SaveDetailsFreshUserSuccessState(businessRegisterModel: businessRegisterModel));
//       }
//
//     }else{
//       emit(SaveErrorState(errorMsg: "${results?.data}  ${results?.message}"));
//     }
//
//
// }
//   }
// }
//
//
//
//
// abstract class SaveDetailsEvent{}
// class SaveBusinessDetailsEvent extends SaveDetailsEvent{
//   final BusinessData businessData;
//   final String vendorId;
//   SaveBusinessDetailsEvent({required this.businessData,required this.vendorId});
// }
//
// class SaveBusinessDetailsPatchFieldEvent extends SaveDetailsEvent{
//   final Map<String,dynamic> mapData;
//   final String vendorId;
//   SaveBusinessDetailsPatchFieldEvent({required this.mapData,
//     required this.vendorId});
// }
//
// class GetBusinessDetailsEvent extends SaveDetailsEvent{
//   final String emailOrPhone;
//   GetBusinessDetailsEvent
//       ({required this.emailOrPhone});
// }
// abstract class SaveDetailsState extends Equatable{}
//  class SaveInitState extends SaveDetailsState{
//   @override
//   List<Object?> get props => [];
//  }
//
// class SaveLoadingState extends SaveDetailsState{
//   @override
//   List<Object?> get props => [];
// }
// class SaveBusinessDetailAlreadyFillState extends SaveDetailsState{
//
//
//   SaveBusinessDetailAlreadyFillState();
//   @override
//   List<Object?> get props => [];
// }
// class SaveDetailsFreshUserSuccessState extends SaveDetailsState{
//  final  BusinessRegisterModel businessRegisterModel;
//   SaveDetailsFreshUserSuccessState({required this.businessRegisterModel});
//   @override
//   List<Object?> get props => [];
// }
// class SaveErrorState extends SaveDetailsState{
//   final String errorMsg;
//   SaveErrorState({required this.errorMsg});
//   @override
//   List<Object?> get props => [];
// }










import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import '../model/business_resister_model.dart';
import '../repository/save_repository.dart';

class SaveDetailsBloc extends Bloc<SaveDetailsEvent, SaveDetailsState> {
  SaveDetailsBloc() : super(SaveInitState()) {
    on<SaveBusinessDetailsEvent>(_onSaveBusinessDetails);
    on<SaveBusinessDetailsPatchFieldEvent>(_onPatchField);
    on<GetBusinessDetailsEvent>(_onGetBusinessDetails);
  }

  // Save Full Business Details
  Future<void> _onSaveBusinessDetails(
      SaveBusinessDetailsEvent event, Emitter<SaveDetailsState> emit) async {
    emit(SaveLoadingState());

    try {
      final results = await SaveRepository.instance.patchBusinessDetails(
        mapData: event.businessData.toJson()..removeWhere((key, value) => value == null),
        vendorId: event.vendorId,
      );

      if (results?.statusCode == 200 || results?.statusCode == 201) {
        final model = BusinessRegisterModel.fromJson(results!.data);
        BusinessProfileData.saveBusinessRegistrationData(model);

        // We just saved → pass the model so UI knows to save locally
        emit(SaveBusinessDetailAlreadyFillState(justSavedModel: model));
      } else {
        emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
      }
    } catch (e) {
      emit(SaveErrorState(errorMsg: e.toString()));
    }
  }

  // Patch Individual Field
  Future<void> _onPatchField(
      SaveBusinessDetailsPatchFieldEvent event, Emitter<SaveDetailsState> emit) async {
    emit(SaveLoadingState());

    try {
      final results = await SaveRepository.instance.patchBusinessDetails(
        mapData: event.mapData,
        vendorId: event.vendorId,
      );

      if (results?.statusCode == 200 || results?.statusCode == 201) {
        final model = BusinessRegisterModel.fromJson(results!.data);
        final existingModel = BusinessProfileData.getBusinessRegistrationData();

        if (existingModel != null && existingModel.businessData != null) {
          // 1. Merge non-null fields from the response
          if (model.businessData != null) {
            final newBusData = model.businessData!;
            final oldBusData = existingModel.businessData!;

            if (newBusData.pubCafeFineDinningDescription != null) {
              oldBusData.pubCafeFineDinningDescription = newBusData.pubCafeFineDinningDescription;
            }
            if (newBusData.pubCafeFineDinningName != null) {
              oldBusData.pubCafeFineDinningName = newBusData.pubCafeFineDinningName;
            }
            if (newBusData.isPubPause != null) {
              oldBusData.isPubPause = newBusData.isPubPause;
            }
            if (newBusData.email != null) oldBusData.email = newBusData.email;
            if (newBusData.website != null) oldBusData.website = newBusData.website;
            if (newBusData.approxPrice != null) oldBusData.approxPrice = newBusData.approxPrice;
            if (newBusData.businessRegistrationName != null) oldBusData.businessRegistrationName = newBusData.businessRegistrationName;
            if (newBusData.constitution != null) oldBusData.constitution = newBusData.constitution;
            if (newBusData.phoneNo != null) oldBusData.phoneNo = newBusData.phoneNo;
            if (newBusData.address != null) oldBusData.address = newBusData.address;
            if (newBusData.city != null) oldBusData.city = newBusData.city;
            if (newBusData.state != null) oldBusData.state = newBusData.state;
            if (newBusData.country != null) oldBusData.country = newBusData.country;
            if (newBusData.pinCode != null) oldBusData.pinCode = newBusData.pinCode;
            if (newBusData.latitude != null) oldBusData.latitude = newBusData.latitude;
            if (newBusData.longitude != null) oldBusData.longitude = newBusData.longitude;
            if (newBusData.featuresFacilities.isNotEmpty) oldBusData.featuresFacilities = newBusData.featuresFacilities;
            if (newBusData.uniques.isNotEmpty) oldBusData.uniques = newBusData.uniques;
            if (newBusData.foodType != null) oldBusData.foodType = newBusData.foodType;
          }

          // 2. Ensure mapData fields themselves are written to existingModel as fallback/primary
          event.mapData.forEach((key, value) {
            if (key == 'pub_cafe_fine_dinning_name') {
              existingModel.businessData!.pubCafeFineDinningName = value?.toString();
            } else if (key == 'isPubPause') {
              existingModel.businessData!.isPubPause = value is bool ? value : (value?.toString().toLowerCase() == 'true');
            } else if (key == 'pub_cafe_fine_dinning_description') {
              existingModel.businessData!.pubCafeFineDinningDescription = value?.toString();
            } else if (key == 'email') {
              existingModel.businessData!.email = value?.toString();
            } else if (key == 'website') {
              existingModel.businessData!.website = value?.toString();
            } else if (key == 'approx_price') {
              existingModel.businessData!.approxPrice = value is int ? value : int.tryParse(value?.toString() ?? '');
            } else if (key == 'features_facilities' && value is List) {
              existingModel.businessData!.featuresFacilities = List<String>.from(value.map((e) => e.toString()));
            } else if (key == 'uniques' && value is List) {
              existingModel.businessData!.uniques = List<String>.from(value.map((e) => e.toString()));
            }
          });

          BusinessProfileData.saveBusinessRegistrationData(existingModel);
          emit(SaveBusinessDetailAlreadyFillState(justSavedModel: existingModel));
        } else {
          BusinessProfileData.saveBusinessRegistrationData(model);
          emit(SaveBusinessDetailAlreadyFillState(justSavedModel: model));
        }
      } else {
        emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
      }
    } catch (e) {
      emit(SaveErrorState(errorMsg: e.toString()));
    }
  }

  // Get Business Details (on app start)
  Future<void> _onGetBusinessDetails(
      GetBusinessDetailsEvent event, Emitter<SaveDetailsState> emit) async {
    emit(SaveLoadingState());

    try {
      final results = await SaveRepository.instance.saveBusinessDetails(
        mapData: {
          event.emailOrPhone.contains("@") ? "email" : "phone_no": event.emailOrPhone
        },
      );

      if (results?.statusCode == 200 || results?.statusCode == 201) {
        final businessRegisterModel = BusinessRegisterModel.fromJson(results!.data);

        if (businessRegisterModel.businessData?.businessRegistrationName != null &&
            businessRegisterModel.businessData!.businessRegistrationName!.isNotEmpty) {
          BusinessProfileData.saveBusinessRegistrationData(businessRegisterModel);
          // Profile already exists → no model passed
          emit(SaveBusinessDetailAlreadyFillState());
        } else {
          emit(SaveDetailsFreshUserSuccessState(businessRegisterModel: businessRegisterModel));
        }
      } else {
        emit(SaveErrorState(errorMsg: "${results?.data} ${results?.message}"));
      }
    } catch (e) {
      emit(SaveErrorState(errorMsg: e.toString()));
    }
  }
}

// ======================== EVENTS ========================
abstract class SaveDetailsEvent {}

class SaveBusinessDetailsEvent extends SaveDetailsEvent {
  final BusinessData businessData;
  final String vendorId;
  SaveBusinessDetailsEvent({required this.businessData, required this.vendorId});
}

class SaveBusinessDetailsPatchFieldEvent extends SaveDetailsEvent {
  final Map<String, dynamic> mapData;
  final String vendorId;
  SaveBusinessDetailsPatchFieldEvent({required this.mapData, required this.vendorId});
}

class GetBusinessDetailsEvent extends SaveDetailsEvent {
  final String emailOrPhone;
  GetBusinessDetailsEvent({required this.emailOrPhone});
}

// ======================== STATES ========================
abstract class SaveDetailsState extends Equatable {}

class SaveInitState extends SaveDetailsState {
  @override
  List<Object?> get props => [];
}

class SaveLoadingState extends SaveDetailsState {
  @override
  List<Object?> get props => [];
}

// Updated: Now carries optional model to know "did we just save?"
class SaveBusinessDetailAlreadyFillState extends SaveDetailsState {
  final BusinessRegisterModel? justSavedModel;

  SaveBusinessDetailAlreadyFillState({this.justSavedModel});

  @override
  List<Object?> get props => [justSavedModel];
}

class SaveDetailsFreshUserSuccessState extends SaveDetailsState {
  final BusinessRegisterModel businessRegisterModel;
  SaveDetailsFreshUserSuccessState({required this.businessRegisterModel});
  @override
  List<Object?> get props => [businessRegisterModel];
}

class SaveErrorState extends SaveDetailsState {
  final String errorMsg;
  SaveErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}