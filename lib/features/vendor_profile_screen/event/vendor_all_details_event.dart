import 'package:equatable/equatable.dart';

abstract class VendorAllDetailsEvent extends Equatable {}

class FetchVendorAllDetailsEvent extends VendorAllDetailsEvent {
  final String vendorId;

  FetchVendorAllDetailsEvent({required this.vendorId});

  @override
  List<Object?> get props => [vendorId];
}