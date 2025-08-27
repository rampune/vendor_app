import '../../../data/source/network/dio_client.dart';

abstract class PubCafeGalleryEvent {}

class PubCafeGalleryUploadEvent extends PubCafeGalleryEvent {
  final List<ImageUploadModel> listImageUploadModel;
  final String vendorId;

  PubCafeGalleryUploadEvent({
    required this.vendorId,
    required this.listImageUploadModel,
  });
}