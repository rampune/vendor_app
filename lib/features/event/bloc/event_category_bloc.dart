import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/event/model/event_category_model.dart';
import 'package:new_pubup_partner/features/event/repository/event_category_repository.dart';
class EventCategoryBloc extends Bloc<EventCategoryEvent,EventCategoryState>{
  EventCategoryBloc():super(EventCategoryInitState()){
    on(handler);
  }
  handler(EventCategoryEvent event,Emitter<EventCategoryState> emit)async{
    if(event is EventCategoryGetEvent){
      emit(EventCategoryLoadingState());
try{

  ApiResults results=await EventCategoryRepository.getEventCategory();
  if(results.statusCode==200){
   emit(EventCategorySuccessState(eventCategoryModel: EventCategoryModel.fromJson(results.data)));
  }else{
    emit(EventCategoryErrorState(errorMsg:"${results.data} ${results.message}"));
  }

}
catch(exception){
  emit(EventCategoryErrorState(errorMsg: "$exception"));
}
    }

  }
}
abstract class EventCategoryEvent {}
class EventCategoryGetEvent extends EventCategoryEvent{}
abstract class EventCategoryState extends Equatable{ }

class EventCategoryInitState extends EventCategoryState{
  @override
  List<Object?> get props => [];
}

class EventCategoryLoadingState extends EventCategoryState{
  @override
  List<Object?> get props => [];
}

class EventCategorySuccessState extends EventCategoryState{
  final EventCategoryModel eventCategoryModel;
  EventCategorySuccessState({required this.eventCategoryModel});

  @override
  List<Object?> get props => [];
}
class EventCategoryErrorState extends EventCategoryState{
  final String errorMsg;
  EventCategoryErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}
