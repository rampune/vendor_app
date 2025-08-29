
// pub_cafe_all_details_bloc.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/source/network/api_result_handler.dart';
import '../event/vendor_all_details_event.dart';
import '../model/vendor_all_detail_model.dart';
import '../repository/vendor_all_details_repository.dart';
import '../state/vendor_all_details_state.dart';


class VendorAllDetailsBloc extends Bloc<VendorAllDetailsEvent, VendorAllDetailsState> {
  VendorAllDetailsBloc() : super(VendorAllDetailsInitState()) {
    on<FetchVendorAllDetailsEvent>(handler);
  }

  Future<void> handler(FetchVendorAllDetailsEvent event, Emitter<VendorAllDetailsState> emit) async {
    try {
      emit(VendorAllDetailsLoadingState());

      ApiResults? apiResults = await VendorAllDetailsRepository().fetchVendorAllDetailsById(event.vendorId);
      debugPrint('API Results: $apiResults');

      if (apiResults?.statusCode == 200) {
        final fullData = apiResults?.data as Map<String, dynamic>? ?? {};
        print('Full data: $fullData'); // Debug the full response
        final vendorAllDetailsResponse = VendorAllDetailsResponse.fromJson(fullData);
        final vendorAllDetailsData = vendorAllDetailsResponse.data ?? PubCafeVendorModel(
          id: 0,
          vendorDetails: null,
          vendorStatus: null,
          vendorDeviceTokens: null,
          vendorId: '',
          businessType: '',
          businessRegistrationName: '',
          constitution: '',
          email: '',
          phoneNo: '',
          website: '',
          address: '',
          city: '',
          state: '',
          country: '',
          pinCode: '',
          status: '',
          deviceToken: null,
        ); // Fallback with default values
        emit(VendorAllDetailsSuccessState(vendorAllDetailsData: vendorAllDetailsData));
      } else {
        emit(VendorAllDetailsErrorState(errorMsg: 'Failed to load details, status: ${apiResults?.statusCode}'));
      }
      print("Pub All Detail data: ${apiResults?.data}");
    } catch (exception) {
      print('Exception in handler: $exception');
      emit(VendorAllDetailsErrorState(errorMsg: 'An error occurred: $exception'));
    }
  }
}
