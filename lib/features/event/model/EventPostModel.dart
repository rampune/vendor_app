//
//
// import 'dart:convert';
//
// import 'package:new_pubup_partner/features/event/event_controller/event_controller.dart';
//
// class EventPostModel {
//   int? id;
//   String? vendorData;
//   String? eventName;
//   String? eventDate;
//   String? startTime;
//   String? endTime;
//   String? venue;
//   String? howManyDays;
//   String? description;
//   String? faqDetails;
//   String? minumumAgeRequirements;
//   String? seatingArrangement;
//   String? kidsFriendly;
//   String? petsFriendly;
//  String? keywords;
//   String? termConditions;
//   String? artists;
//   String? artistsDatas;
//   String ? ticketModelInString;
//   String ? tables;
//   String?status;
//   String? event_category_data;
// String? location;
//   String ?bannerImg,galaryImagePath1,
//   galaryImagePath2
//   ,galaryImagePath3
//   ,layout,parkingType;
//   bool? isEventPause;
//
//
//
//   EventPostModel(
//       {
//         this.id,
//         this.vendorData,
//         this.eventName,
//         this.location,
//         this.eventDate,
//         this.startTime,
//         this.endTime,
//         this.venue,
//         this.howManyDays,
//         this.description,
//         this.faqDetails,
//         this.minumumAgeRequirements,
//         this.seatingArrangement,
//         this.kidsFriendly,
//         this.petsFriendly,
//         this.keywords,
//         this.termConditions,
//         this.artists,
//         this.artistsDatas,
//         this.ticketModelInString,
//         this.tables,this.layout,this.galaryImagePath1,
//         this.galaryImagePath2,this.galaryImagePath3,
//         this.bannerImg,this.parkingType,
//         this.event_category_data,
//         this.isEventPause = false,
//       });
//
//
//   EventPostModel.fromJson(Map<String, dynamic> json) {
//     // id = json['id'];
//     id = int.tryParse(json['id']?.toString() ?? '');
//     event_category_data=json['event_category_data'];
//     bannerImg = json['bannerImg'];
//     galaryImagePath1 = json['galaryImagePath1'];
//     galaryImagePath2 = json['galaryImagePath2'];
//     galaryImagePath3 = json['galaryImagePath3'];
//     location=json["location"];
//     layout = json['layout'];
//     parkingType = json['parking_type'];
//     status=json['status'];
//     vendorData = json['vendor_data'];
//     eventName = json['event_name'];
//     eventDate = json['event_date'];
//     startTime = json['start_time'];
//     endTime = json['end_time'];
//     venue = json['location'];
//     howManyDays = json['how_many_days'];
//     description = json['description'];
//     faqDetails = json['faq_details'];
//     minumumAgeRequirements = json['minumum_age_requirements'];
//     seatingArrangement = json['seating_arrangement'];
//     kidsFriendly = json['kids_friendly'];
//     petsFriendly = json['pets_friendly'];
//     keywords = json['keywords'];
//     ticketModelInString=json['tickets'];
//     termConditions = json['term_conditions'];
//     artists=json['artists'];
//     tables=json['tables'];
//
//     // Safe bool parsing: handle string "true"/"false" or actual bool
//     final pauseValue = json['isEventPause'];
//     if (pauseValue is bool) {
//       isEventPause = pauseValue;
//     } else if (pauseValue is String) {
//       isEventPause = pauseValue.toLowerCase() == 'true';
//     } else {
//       isEventPause = false;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status']=this.status;
//     data['bannerImg'] = this.bannerImg;
//     data['galaryImagePath1'] = this.galaryImagePath1;
//     data['galaryImagePath2'] = this.galaryImagePath2;
//     data['galaryImagePath3'] = this.galaryImagePath3;
//     data['layout'] = this.layout;
//     data['parking_type'] = this.parkingType;
//     data['event_category_data']=this.event_category_data;
//     data["location"]=this.location;
//     data['vendor_data'] = this.vendorData;
//     data['event_name'] = this.eventName;
//     data['event_date'] = this.eventDate;
//     data['start_time'] = this.startTime;
//     data['end_time'] = this.endTime;
//     data['venue'] = this.venue;
//     data['how_many_days'] = this.howManyDays;
//     data['description'] = this.description;
//     data['faq_details'] = this.faqDetails;
//     data['minumum_age_requirements'] = this.minumumAgeRequirements;
//     data['seating_arrangement'] = this.seatingArrangement;
//     data['kids_friendly'] = this.kidsFriendly;
//     data['pets_friendly'] = this.petsFriendly;
//     data['keywords'] = this.keywords;
//     data['term_conditions'] = this.termConditions;
//     data['tickets']=this.ticketModelInString??"[]";
//     // data['artists']=this.artists??"[]";
//
//
//     // final List<int> artistIds = EventController.artistDataList
//     //     .where((artist) => artist.id != null)
//     //     .map((artist) => artist.id!)
//     //     .toList();
//     //
//     //
//     // data['artists_datas'] = artistIds.isEmpty ? "" : artistIds.join(',');
//
//
//
//     data['tables']=this.tables??"[]";
//     data['isEventPause'] = this.isEventPause;
//
//     return data;
//   }
// }
//
//
//
// ///Old code before artist selection logic change
// // class ArtistsModel {
// //   String? artistName;
// //   String? artistCategory;
// //   String? aboutArtist;
// //   String? imgPath;
// //
// //   ArtistsModel({this.artistName, this.artistCategory, this.aboutArtist,
// //   this.imgPath});
// //
// //   ArtistsModel.fromJson(Map<String, dynamic> json) {
// //     artistName = json['artist_name'];
// //     artistCategory = json['artist_category'];
// //     aboutArtist = json['about_artist'];
// //     imgPath=json['artist_image'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['artist_name'] = this.artistName;
// //     data['artist_category'] = this.artistCategory;
// //     data['about_artist'] = this.aboutArtist;
// //     data['artist_image']=this.imgPath;
// //     return data;
// //   }
// // }
//
//
// ///new code after artist selection logic change
// class ArtistsModel {
//   final int? id;
//   final String? artistName;
//   final String? artistCategory;
//   final String? aboutArtist;
//   String? imgPath;
//
//   ArtistsModel({
//     this.id,
//     this.artistName,
//     this.artistCategory,
//     this.aboutArtist,
//     this.imgPath,
//   });
//
//   ArtistsModel.idOnly(int this.id)
//       : artistName = null,
//         artistCategory = null,
//         aboutArtist = null,
//         imgPath = null;
//
//
//   factory ArtistsModel.fromJson(Map<String, dynamic> json) {
//     return ArtistsModel(
//       // id: json['id'] as int?,
//       // artistName: json['artistName'] as String?,
//       // artistCategory: json['artistCategory'] as String?,
//       // aboutArtist: json['aboutArtist'] as String?,
//       // imgPath: json['imgPath'] as String?,
//
//       id: json['id'] as int?,
//       artistName: json['artist_name'] as String?,
//       artistCategory: json['artist_category'] as String?,
//       aboutArtist: json['about_artist'] as String?,
//       imgPath: json['artist_image'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       // 'id': id,
//       // 'artistName': artistName,
//       // 'artistCategory': artistCategory,
//       // 'aboutArtist': aboutArtist,
//       // 'imgPath': imgPath,
//       'id': id,
//       'artist_name': artistName,
//       'artist_category': artistCategory,
//       'about_artist': aboutArtist,
//       'artist_image': imgPath,
//
//     };
//   }
//
//
//
//
//   ArtistsModel copyWith({
//     int? id,
//     String? artistName,
//     String? artistCategory,
//     String? aboutArtist,
//     String? imgPath,
//   }) {
//     return ArtistsModel(
//       id: id ?? this.id,
//       artistName: artistName ?? this.artistName,
//       artistCategory: artistCategory ?? this.artistCategory,
//       aboutArtist: aboutArtist ?? this.aboutArtist,
//       imgPath: imgPath ?? this.imgPath,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is ArtistsModel &&
//               runtimeType == other.runtimeType &&
//               artistName == other.artistName;
//
//   @override
//   int get hashCode => artistName.hashCode;
// }
//
// class TicketModel {
//   String? ticketType;
//   String? description;
//   int? price;
//   bool? isFree;
//   String? coverCharges;
//
//   bool? isCoupleFree;
//
//   TicketModel(
//       {this.ticketType,
//         this.description,
//         this.price,
//         this.isFree,
//         this.coverCharges,
//
//         this.isCoupleFree
//       });
//
//   TicketModel.fromJson(Map<String, dynamic> json) {
//     ticketType = json['ticket_type'];
//     description = json['description'];
//     price = json['price'];
//     isFree = json['is_free'];
//     coverCharges = json['cover_charges'];
//
//     isCoupleFree = json['is_couple_free'];
//
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ticket_type'] = this.ticketType;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['is_free'] = this.isFree;
//     data['cover_charges'] = this.coverCharges;
//
//     data['is_couple_free'] = this.isCoupleFree;
//     return data;
//   }
// }
//
// class EventTableModel {
//   String? numberOfTables;
//   String? sittingCapacity;
//   int? tablePrice;
//   String? coverCharges;
//   EventTableModel(
//       {this.numberOfTables,
//         this.sittingCapacity,
//         this.tablePrice,
//         this.coverCharges});
//
//   EventTableModel.fromJson(Map<String, dynamic> json) {
//     numberOfTables = json['number_of_tables'];
//     sittingCapacity = json['sitting_capacity'];
//     tablePrice = json['table_price'];
//     coverCharges = json['cover_charges'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['number_of_tables'] = this.numberOfTables;
//     data['sitting_capacity'] = this.sittingCapacity;
//     data['table_price'] = this.tablePrice;
//     data['cover_charges'] = this.coverCharges;
//     return data;
//   }
// }




















import 'dart:convert';


class EventPostModel {
  int? id;
  String? vendorData;
  String? eventName;
  String? eventDate;
  String? startTime;
  String? endTime;
  String? venue;
  String? howManyDays;
  String? description;
  String? faqDetails;
  String? minumumAgeRequirements;
  String? foodType;
  String? seatingArrangement;
  String? kidsFriendly;
  String? petsFriendly;
  String? keywords;
  String? termConditions;

  List<int>? artistsDatas;
  String ? ticketModelInString;
  String ? tables;
  String?status;
  String? event_category_data;
  String? location;
  String ?bannerImg,galaryImagePath1,
      galaryImagePath2
  ,galaryImagePath3
  ,layout, venueLayoutPhoto, parkingType;
  bool? isEventPause;
  bool? isEventCancel;



  EventPostModel(
      {
        this.id,
        this.vendorData,
        this.eventName,
        this.location,
        this.eventDate,
        this.startTime,
        this.endTime,
        this.venue,
        this.howManyDays,
        this.description,
        this.faqDetails,
        this.status,
        this.minumumAgeRequirements,
        this.foodType,
        this.seatingArrangement,
        this.kidsFriendly,
        this.petsFriendly,
        this.keywords,
        this.termConditions,
        this.artistsDatas,
        this.ticketModelInString,
        this.tables,this.layout, this.venueLayoutPhoto, this.galaryImagePath1,
        this.galaryImagePath2,this.galaryImagePath3,
        this.bannerImg,this.parkingType,
        this.event_category_data,
        this.isEventPause = false,
        this.isEventCancel = false,
      });

  factory EventPostModel.fromJson(Map<String, dynamic> json) {
    List<int> parseArtists() {
      final raw = json['artists_datas'];
      if (raw == null) return [];
      if (raw is List) {
        return raw.map((e) {
          if (e is Map) {
            return int.tryParse(e['id']?.toString() ?? '0') ?? 0;
          }
          return int.tryParse(e.toString()) ?? 0;
        }).where((e) => e > 0).toList();
      }
      if (raw is String && raw.isNotEmpty) {
        try {
          final List<dynamic> list = jsonDecode(raw);
          return list.map((e) {
            if (e is Map) {
              return int.tryParse(e['id']?.toString() ?? '0') ?? 0;
            }
            return int.tryParse(e.toString()) ?? 0;
          }).where((e) => e > 0).toList();
        } catch (_) {
          return [];
        }
      }
      return [];
    }

    // Helper to parse galleries
    List<String> parseGalleries() {
      final raw = json['galleries'];
      if (raw is List) {
        return raw.map((e) => e.toString()).toList();
      }
      if (raw is String && raw.isNotEmpty) {
        try {
          final List<dynamic> list = jsonDecode(raw);
          return list.map((e) => e.toString()).toList();
        } catch (_) {}
      }
      return [];
    }

    final galleries = parseGalleries();

    // Helper to handle categories - keep raw JSON for ID parsing
    String parseCategoriesRaw() {
      final raw = json['event_category_data'];
      if (raw == null) return '[]';
      if (raw is String) return raw;
      return jsonEncode(raw);
    }

    return EventPostModel(
      id: int.tryParse(json['id']?.toString() ?? ''),
      event_category_data: parseCategoriesRaw(),
      bannerImg: json['event_banner'] ?? json['bannerImg'],
      galaryImagePath1: galleries.isNotEmpty ? galleries[0] : json['galaryImagePath1'],
      galaryImagePath2: galleries.length > 1 ? galleries[1] : json['galaryImagePath2'],
      galaryImagePath3: galleries.length > 2 ? galleries[2] : json['galaryImagePath3'],
      location: json["location"],
      layout: json['layout'],
      venueLayoutPhoto: json['venue_layout'],
      parkingType: json['parking_type'],
      vendorData: json['vendor_data'],
      eventName: json['event_name'],
      eventDate: json['event_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      venue: json['venue'],
      status: json['status'] ,
      howManyDays: json['how_many_days'],
      description: json['description'],
      faqDetails: json['faq_details'],
      minumumAgeRequirements: json['minumum_age_requirements'],
      foodType: json['food_type'],
      seatingArrangement: json['seating_arrangement'],
      kidsFriendly: json['kids_friendly'],
      petsFriendly: json['pets_friendly'],
      keywords: json['keywords'],
      ticketModelInString: json['tickets'] is String ? json['tickets'] : jsonEncode(json['tickets'] ?? []),
      termConditions: json['term_conditions'],
      tables: json['tables'] is String ? json['tables'] : jsonEncode(json['tables'] ?? []),
      artistsDatas: parseArtists(),
      isEventPause: (json['isEventPause'] is bool)
          ? json['isEventPause']
          : (json['isEventPause'] is String)
          ? json['isEventPause'].toLowerCase() == 'true'
          : false,
      isEventCancel: (json['isEventCancel'] is bool)
          ? json['isEventCancel']
          : (json['isEventCancel'] is String)
          ? json['isEventCancel'].toLowerCase() == 'true'
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status']=this.status;
    data['bannerImg'] = this.bannerImg;
    data['galaryImagePath1'] = this.galaryImagePath1;
    data['galaryImagePath2'] = this.galaryImagePath2;
    data['galaryImagePath3'] = this.galaryImagePath3;
    data['layout'] = this.layout;
    data['venue_layout'] = this.venueLayoutPhoto;
    data['parking_type'] = this.parkingType;
    data['event_category_data']=this.event_category_data;
    data["location"]=this.location;
    data['vendor_data'] = this.vendorData;
    data['event_name'] = this.eventName;
    data['event_date'] = this.eventDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['venue'] = this.venue;
    data['how_many_days'] = this.howManyDays;
    data['description'] = this.description;
    data['faq_details'] = this.faqDetails;
    data['minumum_age_requirements'] = this.minumumAgeRequirements;
    data['food_type'] = this.foodType;
    data['seating_arrangement'] = this.seatingArrangement;
    data['kids_friendly'] = this.kidsFriendly;
    data['pets_friendly'] = this.petsFriendly;
    data['keywords'] = this.keywords;
    data['term_conditions'] = this.termConditions;
    data['tickets']=this.ticketModelInString??"[]";
    data['artists_datas'] = artistsDatas ?? [];
    data['tables']=this.tables??"[]";
    data['isEventPause'] = this.isEventPause;
    data['isEventCancel'] = this.isEventCancel;

    return data;
  }

  String getCategoryNames() {
    if (event_category_data == null || event_category_data!.isEmpty) return '';
    try {
      final decoded = jsonDecode(event_category_data!);
      if (decoded is List) {
        return decoded.map((e) => e is Map ? (e['name']?.toString() ?? '') : e.toString()).where((n) => n.isNotEmpty).join(', ');
      }
      return event_category_data!;
    } catch (_) {
      return event_category_data!;
    }
  }

  List<int> getCategoryIds() {
    if (event_category_data == null || event_category_data!.isEmpty) return [];
    try {
      final decoded = jsonDecode(event_category_data!);
      if (decoded is List) {
        return decoded.map((e) => int.tryParse(e is Map ? (e['id']?.toString() ?? '0') : e.toString()) ?? 0).where((id) => id > 0).toList();
      }
      return [];
    } catch (_) {
      return event_category_data!.split(',').map((e) => int.tryParse(e.trim()) ?? 0).where((id) => id > 0).toList();
    }
  }

  EventPostModel copyWith({
    int? id,
    String? vendorData,
    String? eventName,
    String? eventDate,
    String? startTime,
    String? endTime,
    String? venue,
    String? howManyDays,
    String? description,
    String? faqDetails,
    String? minumumAgeRequirements,
    String? foodType,
    String? seatingArrangement,
    String? kidsFriendly,
    String? petsFriendly,
    String? keywords,
    String? termConditions,
    List<int>? artistsDatas,
    String? ticketModelInString,
    String? tables,
    String? status,
    String? event_category_data,
    String? location,
    String? bannerImg,
    String? galaryImagePath1,
    String? galaryImagePath2,
    String? galaryImagePath3,
    String? layout,
    String? venueLayoutPhoto,
    String? parkingType,
    bool? isEventPause,
    bool? isEventCancel,
  }) {
    return EventPostModel(
      id: id ?? this.id,
      vendorData: vendorData ?? this.vendorData,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venue: venue ?? this.venue,
      howManyDays: howManyDays ?? this.howManyDays,
      description: description ?? this.description,
      faqDetails: faqDetails ?? this.faqDetails,
      minumumAgeRequirements: minumumAgeRequirements ?? this.minumumAgeRequirements,
      foodType: foodType ?? this.foodType,
      seatingArrangement: seatingArrangement ?? this.seatingArrangement,
      kidsFriendly: kidsFriendly ?? this.kidsFriendly,
      petsFriendly: petsFriendly ?? this.petsFriendly,
      keywords: keywords ?? this.keywords,
      termConditions: termConditions ?? this.termConditions,
      artistsDatas: artistsDatas ?? this.artistsDatas,
      ticketModelInString: ticketModelInString ?? this.ticketModelInString,
      tables: tables ?? this.tables,
      status: status ?? this.status,
      event_category_data: event_category_data ?? this.event_category_data,
      location: location ?? this.location,
      bannerImg: bannerImg ?? this.bannerImg,
      galaryImagePath1: galaryImagePath1 ?? this.galaryImagePath1,
      galaryImagePath2: galaryImagePath2 ?? this.galaryImagePath2,
      galaryImagePath3: galaryImagePath3 ?? this.galaryImagePath3,
      layout: layout ?? this.layout,
      venueLayoutPhoto: venueLayoutPhoto ?? this.venueLayoutPhoto,
      parkingType: parkingType ?? this.parkingType,
      isEventPause: isEventPause ?? this.isEventPause,
      isEventCancel: isEventCancel ?? this.isEventCancel,
    );
  }
}

///new code after artist selection logic change
class ArtistsModel {
  final int? id;
  final String? artistName;
  final String? artistCategory;
  final String? aboutArtist;
  String? imgPath;

  ArtistsModel({
    this.id,
    this.artistName,
    this.artistCategory,
    this.aboutArtist,
    this.imgPath,
  });

  ArtistsModel.idOnly(int this.id)
      : artistName = null,
        artistCategory = null,
        aboutArtist = null,
        imgPath = null;


  factory ArtistsModel.fromJson(Map<String, dynamic> json) {
    return ArtistsModel(
      // id: json['id'] as int?,
      // artistName: json['artistName'] as String?,
      // artistCategory: json['artistCategory'] as String?,
      // aboutArtist: json['aboutArtist'] as String?,
      // imgPath: json['imgPath'] as String?,

      id: json['id'] as int?,
      artistName: json['artist_name'] as String?,
      artistCategory: json['artist_category'] as String?,
      aboutArtist: json['about_artist'] as String?,
      imgPath: json['artist_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'artistName': artistName,
      // 'artistCategory': artistCategory,
      // 'aboutArtist': aboutArtist,
      // 'imgPath': imgPath,
      'id': id,
      'artist_name': artistName,
      'artist_category': artistCategory,
      'about_artist': aboutArtist,
      'artist_image': imgPath,

    };
  }




  ArtistsModel copyWith({
    int? id,
    String? artistName,
    String? artistCategory,
    String? aboutArtist,
    String? imgPath,
  }) {
    return ArtistsModel(
      id: id ?? this.id,
      artistName: artistName ?? this.artistName,
      artistCategory: artistCategory ?? this.artistCategory,
      aboutArtist: aboutArtist ?? this.aboutArtist,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ArtistsModel &&
              runtimeType == other.runtimeType &&
              artistName == other.artistName;

  @override
  int get hashCode => artistName.hashCode;
}

class TicketModel {
  String? ticketType;
  String? description;
  int? price;
  bool? isFree;
  String? coverCharges;

  bool? isCoupleFree;

  bool? isRefundable;
  int? advancePrice;
  int? refundablePrice;
  int? refundablePricePercentage;
  String? refundableTillDate;

  TicketModel(
      {this.ticketType,
        this.description,
        this.price,
        this.isFree,
        this.coverCharges,
        this.isCoupleFree,
        this.isRefundable,
        this.advancePrice,
        this.refundablePrice,
        this.refundablePricePercentage,
        this.refundableTillDate,
      });

  TicketModel.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticket_type'];
    description = json['description'];
    price = json['price'];
    isFree = json['is_free'];
    coverCharges = json['cover_charges'];
    isCoupleFree = json['is_couple_free'];
    isRefundable = json['is_refundable'] is bool 
        ? json['is_refundable'] 
        : (json['is_refundable']?.toString().toLowerCase() == 'true');
    advancePrice = json['advance_price'] is int 
        ? json['advance_price'] 
        : int.tryParse(json['advance_price']?.toString() ?? '');
    refundablePrice = json['refundable_price'] is int 
        ? json['refundable_price'] 
        : int.tryParse(json['refundable_price']?.toString() ?? '');
    refundablePricePercentage = json['refundable_price_percentage'] is int 
        ? json['refundable_price_percentage'] 
        : int.tryParse(json['refundable_price_percentage']?.toString() ?? '');
    refundableTillDate = json['refundable_till_date']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_type'] = this.ticketType;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_free'] = this.isFree;
    data['cover_charges'] = this.coverCharges;
    data['is_couple_free'] = this.isCoupleFree;
    data['is_refundable'] = this.isRefundable ?? false;
    data['advance_price'] = this.advancePrice;
    data['refundable_price'] = this.refundablePrice;
    data['refundable_price_percentage'] = this.refundablePricePercentage;
    data['refundable_till_date'] = this.refundableTillDate;
    return data;
  }
}

class EventTableModel {
  String? numberOfTables;
  String? sittingCapacity;
  int? tablePrice;
  String? coverCharges;
  List<String> tableBenefits;

  bool? isRefundable;
  int? advancePrice;
  int? refundablePrice;
  int? refundablePricePercentage;
  String? refundableTillDate;

  EventTableModel({
    this.numberOfTables,
    this.sittingCapacity,
    this.tablePrice,
    this.coverCharges,
    List<String>? tableBenefits,
    this.isRefundable,
    this.advancePrice,
    this.refundablePrice,
    this.refundablePricePercentage,
    this.refundableTillDate,
  }) : tableBenefits = tableBenefits ?? [];

  EventTableModel.fromJson(Map<String, dynamic> json)
      : numberOfTables = json['number_of_tables']?.toString(),
        sittingCapacity = json['sitting_capacity']?.toString(),
        tablePrice = json['table_price'] is int
            ? json['table_price']
            : int.tryParse(json['table_price']?.toString() ?? ''),
        coverCharges = json['cover_charges']?.toString(),
        tableBenefits = json['table_benefits'] != null
            ? List<String>.from(json['table_benefits'])
            : [],
        isRefundable = json['is_refundable'] is bool 
            ? json['is_refundable'] 
            : (json['is_refundable']?.toString().toLowerCase() == 'true'),
        advancePrice = json['advance_price'] is int 
            ? json['advance_price'] 
            : int.tryParse(json['advance_price']?.toString() ?? ''),
        refundablePrice = json['refundable_price'] is int 
            ? json['refundable_price'] 
            : int.tryParse(json['refundable_price']?.toString() ?? ''),
        refundablePricePercentage = json['refundable_price_percentage'] is int 
            ? json['refundable_price_percentage'] 
            : int.tryParse(json['refundable_price_percentage']?.toString() ?? ''),
        refundableTillDate = json['refundable_till_date']?.toString();

  Map<String, dynamic> toJson() {
    return {
      'number_of_tables': numberOfTables,
      'sitting_capacity': sittingCapacity,
      'table_price': tablePrice,
      'cover_charges': coverCharges,
      'table_benefits': tableBenefits,
      'is_refundable': isRefundable ?? false,
      'advance_price': advancePrice,
      'refundable_price': refundablePrice,
      'refundable_price_percentage': refundablePricePercentage,
      'refundable_till_date': refundableTillDate,
    };
  }
}
