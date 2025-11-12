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
  String? seatingArrangement;
  String? kidsFriendly;
  String? petsFriendly;
 String? keywords;
  String? termConditions;
  String? artists;
  String ? ticketModelInString;
  String ? tables;
  String?status;
  String? event_category_data;
String? location;
  String ?bannerImg,galaryImagePath1,
  galaryImagePath2
  ,galaryImagePath3
  ,layout,parkingType;
  bool? isEventPause;



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
        this.minumumAgeRequirements,
        this.seatingArrangement,
        this.kidsFriendly,
        this.petsFriendly,
        this.keywords,
        this.termConditions,
        this.artists,
        this.ticketModelInString,
        this.tables,this.layout,this.galaryImagePath1,
        this.galaryImagePath2,this.galaryImagePath3,
        this.bannerImg,this.parkingType,
        this.event_category_data,
        this.isEventPause = false,
      });


  EventPostModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    id = int.tryParse(json['id']?.toString() ?? '');
    event_category_data=json['event_category_data'];
    bannerImg = json['bannerImg'];
    galaryImagePath1 = json['galaryImagePath1'];
    galaryImagePath2 = json['galaryImagePath2'];
    galaryImagePath3 = json['galaryImagePath3'];
    location=json["location"];
    layout = json['layout'];
    parkingType = json['parking_type'];
    status=json['status'];
    vendorData = json['vendor_data'];
    eventName = json['event_name'];
    eventDate = json['event_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    venue = json['location'];
    howManyDays = json['how_many_days'];
    description = json['description'];
    faqDetails = json['faq_details'];
    minumumAgeRequirements = json['minumum_age_requirements'];
    seatingArrangement = json['seating_arrangement'];
    kidsFriendly = json['kids_friendly'];
    petsFriendly = json['pets_friendly'];
    keywords = json['keywords'];
    ticketModelInString=json['tickets'];
    termConditions = json['term_conditions'];
    artists=json['artists'];
    tables=json['tables'];

    // Safe bool parsing: handle string "true"/"false" or actual bool
    final pauseValue = json['isEventPause'];
    if (pauseValue is bool) {
      isEventPause = pauseValue;
    } else if (pauseValue is String) {
      isEventPause = pauseValue.toLowerCase() == 'true';
    } else {
      isEventPause = false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status']=this.status;
    data['bannerImg'] = this.bannerImg;
    data['galaryImagePath1'] = this.galaryImagePath1;
    data['galaryImagePath2'] = this.galaryImagePath2;
    data['galaryImagePath3'] = this.galaryImagePath3;
    data['layout'] = this.layout;
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
    data['seating_arrangement'] = this.seatingArrangement;
    data['kids_friendly'] = this.kidsFriendly;
    data['pets_friendly'] = this.petsFriendly;
    data['keywords'] = this.keywords;
    data['term_conditions'] = this.termConditions;
    data['tickets']=this.ticketModelInString??"[]";
    data['artists']=this.artists??"[]";
    data['tables']=this.tables??"[]";
    data['isEventPause'] = this.isEventPause;

    return data;
  }
}

class ArtistsModel {
  String? artistName;
  String? artistCategory;
  String? aboutArtist;
  String? imgPath;

  ArtistsModel({this.artistName, this.artistCategory, this.aboutArtist,
  this.imgPath});

  ArtistsModel.fromJson(Map<String, dynamic> json) {
    artistName = json['artist_name'];
    artistCategory = json['artist_category'];
    aboutArtist = json['about_artist'];
    imgPath=json['artist_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist_name'] = this.artistName;
    data['artist_category'] = this.artistCategory;
    data['about_artist'] = this.aboutArtist;
    data['artist_image']=this.imgPath;
    return data;
  }
}

class TicketModel {
  String? ticketType;
  String? description;
  int? price;
  bool? isFree;
  String? coverCharges;

  bool? isCoupleFree;

  TicketModel(
      {this.ticketType,
        this.description,
        this.price,
        this.isFree,
        this.coverCharges,

        this.isCoupleFree
      });

  TicketModel.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticket_type'];
    description = json['description'];
    price = json['price'];
    isFree = json['is_free'];
    coverCharges = json['cover_charges'];

    isCoupleFree = json['is_couple_free'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_type'] = this.ticketType;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_free'] = this.isFree;
    data['cover_charges'] = this.coverCharges;

    data['is_couple_free'] = this.isCoupleFree;
    return data;
  }
}

class EventTableModel {
  String? numberOfTables;
  String? sittingCapacity;
  int? tablePrice;
  String? coverCharges;
  EventTableModel(
      {this.numberOfTables,
        this.sittingCapacity,
        this.tablePrice,
        this.coverCharges});

  EventTableModel.fromJson(Map<String, dynamic> json) {
    numberOfTables = json['number_of_tables'];
    sittingCapacity = json['sitting_capacity'];
    tablePrice = json['table_price'];
    coverCharges = json['cover_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_tables'] = this.numberOfTables;
    data['sitting_capacity'] = this.sittingCapacity;
    data['table_price'] = this.tablePrice;
    data['cover_charges'] = this.coverCharges;
    return data;
  }
}
