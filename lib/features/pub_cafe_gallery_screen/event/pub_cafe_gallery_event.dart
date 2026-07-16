import 'dart:io';


abstract class PubCafeGalleryEvent {}

class PubCafeGalleryUploadEvent extends PubCafeGalleryEvent {
  final Map<int, File> imagesWithIndex;
  final String vendorId;
  final int existingImagesCount;
  final List<int> removedIndices;

  PubCafeGalleryUploadEvent({
    required this.vendorId,
    required this.imagesWithIndex,
    required this.existingImagesCount,
    this.removedIndices = const [],
  });
}