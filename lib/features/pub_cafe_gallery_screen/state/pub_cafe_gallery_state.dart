import 'package:equatable/equatable.dart';

abstract class PubCafeGalleryState extends Equatable {}

class PubCafeGalleryInitState extends PubCafeGalleryState {
  @override
  List<Object?> get props => [];
}

class PubCafeGalleryLoadingState extends PubCafeGalleryState {
  @override
  List<Object?> get props => [];
}

class PubCafeGalleryErrorState extends PubCafeGalleryState {
  final String errorMsg;

  PubCafeGalleryErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class PubCafeGallerySuccessState extends PubCafeGalleryState {
  @override
  List<Object?> get props => [];
}