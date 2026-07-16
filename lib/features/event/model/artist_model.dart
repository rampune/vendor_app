// features/artist/model/artist_model.dart

class ArtistModel {
  final int id;
  final String artistName;
  final String artistCategory;
  final String aboutArtist;
  final String artistImage; // path like "/artists/image.jpg"

  ArtistModel({
    required this.id,
    required this.artistName,
    required this.artistCategory,
    required this.aboutArtist,
    required this.artistImage,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] ?? 0,
      artistName: json['artist_name'] ?? '',
      artistCategory: json['artist_category'] ?? '',
      aboutArtist: json['about_artist'] ?? '',
      artistImage: json['artist_image'] ?? '',
    );
  }


}

