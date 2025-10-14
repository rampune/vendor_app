// Assuming the response wrapper
import 'package:new_pubup_partner/features/all_bookings/model/booking_model.dart';

class EventBookingsResponse {
  String? status;
  List<EventBookingModel>? data;

  EventBookingsResponse({this.status, this.data});

  factory EventBookingsResponse.fromJson(Map<String, dynamic> json) {
    return EventBookingsResponse(
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => EventBookingModel.fromJson(i)).toList()
          : null,
    );
  }
}
class EventBookingModel {
  int? id;
  final VendorData vendorData;
  final UserData userData;
  // int? eventData;
  
  final EventDataModel eventData;
  String? bookingDate;
  String? bookingDay;
  String? bookingType;
  String? bookingTime;
  int? guestCount;
  int? amountPaid;

  EventBookingModel({
    this.id,
    required this.vendorData,
    required this.userData,
    required this.eventData,
    this.bookingDate,
    this.bookingDay,
    this.bookingType,
    this.bookingTime,
    this.guestCount,
    this.amountPaid,
  });

  factory EventBookingModel.fromJson(Map<String, dynamic> json) {
    return EventBookingModel(
      id: json['id'],
      vendorData: VendorData.fromJson(json['vendor_data'] ?? {}),
      userData: UserData.fromJson(json['user_data'] ?? {}),
      // eventData: json['event_data'],
      eventData: EventDataModel.fromJson(json['event_data']),
      bookingDate: json['booking_date'],
      bookingDay: json['booking_day'],
      bookingType: json['booking_type'],
      bookingTime: json['booking_time'],
      guestCount: json['guest_count'],
      amountPaid: json['amount_paid'],
    );
  }

}




// models/event_data_model.dart (or integrate into existing EventDataModel)
class EventDataModel {
  int? id;
  List<int>? eventCategoryData; // Assuming list of IDs from JSON
  String? eventName;
  String? eventDate;
  String? startTime;
  String? endTime;
  String? description;
  String? faqDetails;
  String? minumumAgeRequirements;
  String? seatingArrangement;
  String? kidsFriendly;
  String? petsFriendly;
  String? layout;
  String? eventBanner;
  String? venueLayout;
  List<String>? galleries;
  String? termConditions;
  List<Artists>? artists;
  List<Tickets>? tickets;
  List<Tables>? tables;
  String? parkingType;
  String? dressCode;
  String? status;
  String? location;
  int? vendorData; // From JSON, it's an int

  EventDataModel({
    this.id,
    this.eventCategoryData,
    this.eventName,
    this.eventDate,
    this.startTime,
    this.endTime,
    this.description,
    this.faqDetails,
    this.minumumAgeRequirements,
    this.seatingArrangement,
    this.kidsFriendly,
    this.petsFriendly,
    this.layout,
    this.eventBanner,
    this.venueLayout,
    this.galleries,
    this.termConditions,
    this.artists,
    this.tickets,
    this.tables,
    this.parkingType,
    this.dressCode,
    this.status,
    this.location,
    this.vendorData,
  });

  factory EventDataModel.fromJson(Map<String, dynamic> json) {
    return EventDataModel(
      id: json['id'],
      eventCategoryData: json['event_category_data']?.cast<int>(),
      eventName: json['event_name'],
      eventDate: json['event_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      description: json['description'],
      faqDetails: json['faq_details'],
      minumumAgeRequirements: json['minumum_age_requirements'],
      seatingArrangement: json['seating_arrangement'],
      kidsFriendly: json['kids_friendly'],
      petsFriendly: json['pets_friendly'],
      layout: json['layout'],
      eventBanner: json['event_banner'],
      venueLayout: json['venue_layout'],
      galleries: json['galleries']?.cast<String>(),
      termConditions: json['term_conditions'],
      artists: json['artists'] != null
          ? (json['artists'] as List).map((v) => Artists.fromJson(v)).toList()
          : null,
      tickets: json['tickets'] != null
          ? (json['tickets'] as List).map((v) => Tickets.fromJson(v)).toList()
          : null,
      tables: json['tables'] != null
          ? (json['tables'] as List).map((v) => Tables.fromJson(v)).toList()
          : null,
      parkingType: json['parking_type'],
      dressCode: json['dress_code'],
      status: json['status'],
      location: json['location'],
      vendorData: json['vendor_data'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_category_data'] = eventCategoryData;
    data['event_name'] = eventName;
    data['event_date'] = eventDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['description'] = description;
    data['faq_details'] = faqDetails;
    data['minumum_age_requirements'] = minumumAgeRequirements;
    data['seating_arrangement'] = seatingArrangement;
    data['kids_friendly'] = kidsFriendly;
    data['pets_friendly'] = petsFriendly;
    data['layout'] = layout;
    data['event_banner'] = eventBanner;
    data['venue_layout'] = venueLayout;
    data['galleries'] = galleries;
    data['term_conditions'] = termConditions;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (tables != null) {
      data['tables'] = tables!.map((v) => v.toJson()).toList();
    }
    data['parking_type'] = parkingType;
    data['dress_code'] = dressCode;
    data['status'] = status;
    data['location'] = location;
    data['vendor_data'] = vendorData;
    return data;
  }
}

// Reuse existing classes for nested objects
class Artists {
  String? artistName;
  String? aboutArtist;
  String? artistImage;
  String? artistCategory;

  Artists({
    this.artistName,
    this.aboutArtist,
    this.artistImage,
    this.artistCategory,
  });

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
      artistName: json['artist_name'],
      aboutArtist: json['about_artist'],
      artistImage: json['artist_image'],
      artistCategory: json['artist_category'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['artist_name'] = artistName;
    data['about_artist'] = aboutArtist;
    data['artist_image'] = artistImage;
    data['artist_category'] = artistCategory;
    return data;
  }
}

class Tickets {
  int? price;
  bool? isFree;
  String? description;
  String? ticketType;
  String? coverCharges;

  Tickets({
    this.price,
    this.isFree,
    this.description,
    this.ticketType,
    this.coverCharges,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) {
    return Tickets(
      price: json['price'],
      isFree: json['is_free'],
      description: json['description'],
      ticketType: json['ticket_type'],
      coverCharges: json['cover_charges'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['is_free'] = isFree;
    data['description'] = description;
    data['ticket_type'] = ticketType;
    data['cover_charges'] = coverCharges;
    return data;
  }
}

class Tables {
  int? tablePrice;
  String? coverCharges;
  String? numberOfTables;
  String? sittingCapacity;

  Tables({
    this.tablePrice,
    this.coverCharges,
    this.numberOfTables,
    this.sittingCapacity,
  });

  factory Tables.fromJson(Map<String, dynamic> json) {
    return Tables(
      tablePrice: json['table_price'],
      coverCharges: json['cover_charges'],
      numberOfTables: json['number_of_tables'],
      sittingCapacity: json['sitting_capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['table_price'] = tablePrice;
    data['cover_charges'] = coverCharges;
    data['number_of_tables'] = numberOfTables;
    data['sitting_capacity'] = sittingCapacity;
    return data;
  }
}