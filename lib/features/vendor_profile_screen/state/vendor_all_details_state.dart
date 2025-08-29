// pub_cafe_all_details_state.dart
import 'package:equatable/equatable.dart';

import '../model/vendor_all_detail_model.dart';

abstract class VendorAllDetailsState extends Equatable {}

class VendorAllDetailsInitState extends VendorAllDetailsState {
  @override
  List<Object?> get props => [];
}

class VendorAllDetailsLoadingState extends VendorAllDetailsState {
  @override
  List<Object?> get props => [];
}

class VendorAllDetailsSuccessState extends VendorAllDetailsState {
  final PubCafeVendorModel vendorAllDetailsData;

  VendorAllDetailsSuccessState({required this.vendorAllDetailsData});

  @override
  List<Object?> get props => [vendorAllDetailsData];
}

class VendorAllDetailsErrorState extends VendorAllDetailsState {
  final String errorMsg;

  VendorAllDetailsErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}