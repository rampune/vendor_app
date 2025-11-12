// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
// import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
// import 'package:new_pubup_partner/data/source/network/dio_client.dart';
// import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';
//
//
// import '../repository/EventPostRepository.dart';
//
// class EventPostBloc extends Bloc<EventPostEvent, EventPostState> {
//   EventPostBloc() : super(EventInitState()) {
//     on(handler);
//   }
//
//   handler(EventPostEvent event, Emitter<EventPostState> emit) async {
//     emit(EventPostLoadingState());
//     if (event is EventUploadPostEvent) {
//
//         ApiResults? apiResult =await EventPostRepository.postEventRepo(
//           listCategory: event.categoryList,
//           mapData: event.eventPostModel.toJson(),
//           listImgUploadModel: event.listImageUploadModel
//         );
//         if(apiResult?.statusCode==200||apiResult?.statusCode==201||apiResult?.statusCode==202){
//           emit(EventPostSuccessState());
//         }else{
//           emit(EventPostErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}  ${apiResult?.statusCode}"));
//         }
// print("amra009\n\n\n${apiResult?.data} ${apiResult?.statusCode} ${apiResult?.message}\n\n\n");
//
//
//
//     } else if(event is EventGetEvent){
//
//       ApiResults ? result=await EventPostRepository.getEventRepo(
//           vendorId: BusinessProfileData.vendorId()??'');
//
//       if(result?.statusCode==200||result?.statusCode==201||result?.statusCode==202){
//         if(result?.data['status']=="success"){
//
//           try{
//             List<dynamic> listDynamic=result?.data['data'];
//
//             log(jsonEncode(listDynamic));
//             List<EventPostModel> getEventList=[];
//             for (int index=0;index<listDynamic.length;index++){
//         //  getEventList.add(GetEventModel.fromJson(listDynamic[index]));
//               final stringifiedMap = (listDynamic[index] as Map<String, dynamic>)
//                   .map<String, String>((key, value) => MapEntry(key, (key=='tickets'||key=='artists'||key=='tables')?jsonEncode(value??'[]'):value?.toString() ?? ''));
//
//               final model = EventPostModel.fromJson(stringifiedMap);
//               getEventList.add(model);
//
//               print("009");
//             }
//             emit(EventGetSuccessState(getEventModelList: getEventList));
//           }catch(exception){
//             emit(EventPostErrorState(errorMsg: "---0009$exception"));
//           }
//
//         }
//
//       }
//
//     }
//
//
//
//
//     else if (event is EventPauseEvent) {
//       ApiResults? result = await EventPostRepository.pauseEventRepo(
//         eventId: event.eventId,
//         isPaused: true,
//       );
//       if (result?.statusCode == 200 || result?.statusCode == 201 ||
//           result?.statusCode == 202) {
//         // Update local state instantly
//         final currentState = state;
//         if (currentState is EventGetSuccessState) {
//           final updatedList = currentState.getEventModelList.map((model) {
//             if (model.id == event.eventId) {
//               // Mutate the model for simplicity (since it's a class instance)
//               model.isEventPause = true;
//               return model;
//             }
//             return model;
//           }).toList();
//           emit(EventGetSuccessState(getEventModelList: updatedList));
//         } else {
//           // Fallback: emit success, but ideally refetch if no list
//           emit(EventPostSuccessState());
//         }
//       } else {
//         emit(EventPostErrorState(
//             errorMsg: "${result?.data} ${result?.message}  ${result
//                 ?.statusCode}"));
//       }
//     }
//
//
//
//     else if (event is EventDeleteEvent) {
//       ApiResults? result = await EventPostRepository.deleteEventRepo(
//         eventId: event.eventId,
//       );
//       if (result?.statusCode == 200 || result?.statusCode == 201 ||
//           result?.statusCode == 202) {
//         // Update local state instantly by removing the event
//         final currentState = state;
//         if (currentState is EventGetSuccessState) {
//           final updatedList = currentState.getEventModelList
//               .where((model) => model.id != event.eventId)
//               .toList();
//           emit(EventGetSuccessState(getEventModelList: updatedList));
//         } else {
//           // Fallback: emit success, but ideally refetch if no list
//           emit(EventPostSuccessState());
//         }
//       } else {
//         emit(EventPostErrorState(
//             errorMsg: "${result?.data} ${result?.message}  ${result
//                 ?.statusCode}"));
//       }
//     }
//
//
//
//
//
//   }
//
// }
//
// abstract class EventPostEvent {}
//
//
// class EventUploadPostEvent extends EventPostEvent {
//   EventPostModel eventPostModel;
//   final List<int> categoryList;
//   final List<ImageUploadModel> listImageUploadModel;
//
//   EventUploadPostEvent({required this.eventPostModel,
//     required this.listImageUploadModel,required this.categoryList
//   });
// }
//
// class EventGetEvent extends EventPostEvent {
//
// }
//
//
// class EventPauseEvent extends EventPostEvent {
//   final int eventId;
//
//   EventPauseEvent({required this.eventId});
// }
//
//
//
//
// class EventDeleteEvent extends EventPostEvent {
//   final int eventId;
//
//   EventDeleteEvent({required this.eventId});
// }
//
//
// abstract class EventPostState extends Equatable {}
//
// class EventInitState extends EventPostState {
//   @override
//   List<Object?> get props => [];
// }
//
// class EventPostLoadingState extends EventPostState {
//   @override
//   List<Object?> get props => [];
// }
//
// class EventPostSuccessState extends EventPostState {
//   @override
//   List<Object?> get props => [];
// }
//
// class EventGetSuccessState extends EventPostState {
//   final List<EventPostModel> getEventModelList;
//   EventGetSuccessState({required this.getEventModelList});
//   @override
//   List<Object?> get props => [];
// }
//
//
// class EventPostErrorState extends EventPostState {
//   final String errorMsg;
//
//   EventPostErrorState({required this.errorMsg});
//
//   @override
//   List<Object?> get props => [];
// }








import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';

import '../repository/EventPostRepository.dart';

class EventPostBloc extends Bloc<EventPostEvent, EventPostState> {
  EventPostBloc() : super(EventInitState()) {
    on(handler);
  }

  handler(EventPostEvent event, Emitter<EventPostState> emit) async {
    emit(EventPostLoadingState());
    if (event is EventUploadPostEvent) {

      ApiResults? apiResult =await EventPostRepository.postEventRepo(
          listCategory: event.categoryList,
          mapData: event.eventPostModel.toJson(),
          listImgUploadModel: event.listImageUploadModel
      );
      if(apiResult?.statusCode==200||apiResult?.statusCode==201||apiResult?.statusCode==202){
        emit(EventPostSuccessState());
      }else{
        emit(EventPostErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}  ${apiResult?.statusCode}"));
      }
      print("amra009\n\n\n${apiResult?.data} ${apiResult?.statusCode} ${apiResult?.message}\n\n\n");



    } else if(event is EventGetEvent){

      ApiResults ? result=await EventPostRepository.getEventRepo(
          vendorId: BusinessProfileData.vendorId()??'');

      if(result?.statusCode==200||result?.statusCode==201||result?.statusCode==202){
        if(result?.data['status']=="success"){

          try{
            List<dynamic> listDynamic=result?.data['data'];

            log(jsonEncode(listDynamic));
            List<EventPostModel> getEventList=[];
            for (int index=0;index<listDynamic.length;index++){
              //  getEventList.add(GetEventModel.fromJson(listDynamic[index]));
              final stringifiedMap = (listDynamic[index] as Map<String, dynamic>)
                  .map<String, String>((key, value) => MapEntry(key, (key=='tickets'||key=='artists'||key=='tables')?jsonEncode(value??'[]'):value?.toString() ?? ''));

              final model = EventPostModel.fromJson(stringifiedMap);
              getEventList.add(model);

              print("009");
            }
            emit(EventGetSuccessState(getEventModelList: getEventList));
          }catch(exception){
            emit(EventPostErrorState(errorMsg: "---0009$exception"));
          }

        }

      }

    }




    else if (event is EventPauseEvent) {
      ApiResults? result = await EventPostRepository.pauseEventRepo(
        eventId: event.eventId,
        isPaused: true,
      );
      if (result?.statusCode == 200 || result?.statusCode == 201 ||
          result?.statusCode == 202) {
        // Update local state instantly
        final currentState = state;
        if (currentState is EventGetSuccessState) {
          final updatedList = currentState.getEventModelList.map((model) {
            if (model.id == event.eventId) {
              // Mutate the model for simplicity (since it's a class instance)
              model.isEventPause = true;
              return model;
            }
            return model;
          }).toList();
          emit(EventGetSuccessState(getEventModelList: updatedList));
        } else {
          // Fallback: emit success, but ideally refetch if no list
          emit(EventPostSuccessState());
        }
      } else {
        emit(EventPostErrorState(
            errorMsg: "${result?.data} ${result?.message}  ${result
                ?.statusCode}"));
      }
    }



    else if (event is EventDeleteEvent) {
      // Optimistic update: Remove immediately for responsive UI
      final currentState = state;
      if (currentState is EventGetSuccessState) {
        final updatedList = currentState.getEventModelList
            .where((model) => model.id != event.eventId)
            .toList();
        emit(EventGetSuccessState(getEventModelList: updatedList));
      }

      ApiResults? result = await EventPostRepository.deleteEventRepo(
        eventId: event.eventId,
      );
      if (result?.statusCode == 200 || result?.statusCode == 204 ||
          result?.statusCode == 201 || result?.statusCode == 202) {
        // Success: Already updated optimistically
        emit(EventPostSuccessState());
      } else {
        // Error: Refetch to restore
        emit(EventPostErrorState(
            errorMsg: "${result?.data} ${result?.message}  ${result?.statusCode}"));
        add(EventGetEvent()); // Refetch on error
      }
    }



    else if (event is EventUpdatePostEvent) {
      // Optimistic update: Update the model in local list
      final currentState = state;
      if (currentState is EventGetSuccessState) {
        final updatedList = currentState.getEventModelList.map((model) {
          if (model.id == event.eventId) {
            // Update with new model data (shallow copy or mutate as needed)
            model.eventName = event.eventPostModel.eventName;
            model.eventDate = event.eventPostModel.eventDate;
            // ... Update other fields as needed (e.g., tickets, artists)
            model.ticketModelInString = event.eventPostModel.ticketModelInString;
            model.artists = event.eventPostModel.artists;
            // Add more fields to update
            return model;
          }
          return model;
        }).toList();
        emit(EventGetSuccessState(getEventModelList: updatedList));
      }

      ApiResults? apiResult = await EventPostRepository.updateEventRepo(
        eventId: event.eventId,
        mapData: event.eventPostModel.toJson(),
        listImgUploadModel: event.listImageUploadModel,
        listCategory: event.categoryList,
      );
      if (apiResult?.statusCode == 200 || apiResult?.statusCode == 201 ||
          apiResult?.statusCode == 202) {
        // Success: Already updated optimistically
        emit(EventPostSuccessState());
      } else {
        // Error: Refetch to restore
        emit(EventPostErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}  ${apiResult?.statusCode}"));
        add(EventGetEvent()); // Refetch on error
      }
    }



  }

}

abstract class EventPostEvent {}


class EventUploadPostEvent extends EventPostEvent {
  EventPostModel eventPostModel;
  final List<int> categoryList;
  final List<ImageUploadModel> listImageUploadModel;

  EventUploadPostEvent({required this.eventPostModel,
    required this.listImageUploadModel,required this.categoryList
  });
}

class EventGetEvent extends EventPostEvent {

}


class EventPauseEvent extends EventPostEvent {
  final int eventId;

  EventPauseEvent({required this.eventId});
}




class EventDeleteEvent extends EventPostEvent {
  final int eventId;

  EventDeleteEvent({required this.eventId});
}


class EventUpdatePostEvent extends EventPostEvent {
  final int eventId;
  final EventPostModel eventPostModel;
  final List<int> categoryList;
  final List<ImageUploadModel> listImageUploadModel;

  EventUpdatePostEvent({
    required this.eventId,
    required this.eventPostModel,
    required this.listImageUploadModel,
    required this.categoryList,
  });
}



abstract class EventPostState extends Equatable {}

class EventInitState extends EventPostState {
  @override
  List<Object?> get props => [];
}

class EventPostLoadingState extends EventPostState {
  @override
  List<Object?> get props => [];
}

class EventPostSuccessState extends EventPostState {
  @override
  List<Object?> get props => [];
}

class EventGetSuccessState extends EventPostState {
  final List<EventPostModel> getEventModelList;
  EventGetSuccessState({required this.getEventModelList});
  @override
  List<Object?> get props => [];
}


class EventPostErrorState extends EventPostState {
  final String errorMsg;

  EventPostErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [];
}