
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/about_pubup/event/about_us_event.dart';
import 'package:new_pubup_partner/features/about_pubup/model/about_us_model.dart';
import 'package:new_pubup_partner/features/about_pubup/repository/about_us_repository.dart';
import 'package:new_pubup_partner/features/about_pubup/state/about_us_state.dart';


class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  AboutUsBloc() : super(AboutUsInitState()) {
    on<AboutUsEvent>(_handler);
  }

  void _handler(AboutUsEvent event, Emitter<AboutUsState> emit) async {
    if (event is GetAboutUsEvent) {
      emit(AboutUsLoadingState());
      ApiResults? result = await AboutUsRepository.getAboutUsRepo();
      if (result?.statusCode == 200 || result?.statusCode == 201 || result?.statusCode == 202) {
        if (result?.data['status'] == "success") {
          try {
            final model = AboutUsModel.fromJson(result?.data['data'] ?? {});
            emit(AboutUsSuccessState(aboutUsModel: model));
          } catch (exception) {
            emit(AboutUsErrorState(errorMsg: "---AboutUsError: $exception"));
          }
        } else {
          emit(AboutUsErrorState(errorMsg: "Failed to load About Us data"));
        }
      } else {
        emit(AboutUsErrorState(errorMsg: "${result?.data} ${result?.message} ${result?.statusCode}"));
      }
    }
  }
}