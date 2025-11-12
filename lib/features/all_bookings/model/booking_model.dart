//
// class BookingResponse {
//   final String status;
//   final List<BookingData> data;
//
//   BookingResponse({required this.status, required this.data});
//
//   factory BookingResponse.fromJson(Map<String, dynamic> json) {
//     return BookingResponse(
//       status: json['status'],
//       data: (json['data'] as List)
//           .map((item) => BookingData.fromJson(item))
//           .toList(),
//     );
//   }
// }
//
// class BookingData {
//   final int id;
//   final VendorData vendorData;
//   final UserData userData;
//   final String bookingDate;
//   final String bookingDay;
//   final String bookingId;
//   final int guestCount;
//   final int amountPaid;
//
//   BookingData({
//     required this.id,
//     required this.vendorData,
//     required this.userData,
//     required this.bookingDate,
//     required this.bookingDay,
//     required this.bookingId,
//     required this.guestCount,
//     required this.amountPaid,
//   });
//
//   factory BookingData.fromJson(Map<String, dynamic> json) {
//     return BookingData(
//       id: json['id'],
//       vendorData: VendorData.fromJson(json['vendor_data']),
//       userData: UserData.fromJson(json['user_data']),
//       bookingDate: json['booking_date'],
//       bookingDay: json['booking_day'],
//       bookingId: json['booking_id'],
//       guestCount: json['guest_count'],
//       amountPaid: json['amount_paid'],
//     );
//   }
// }
//
// class VendorData {
//   final int id;
//   final String vendorId;
//   final String businessType;
//   final String businessRegistrationName;
//   final String email;
//   final String phoneNo;
//   final String website;
//   final String address;
//   final String city;
//   final String state;
//   final String country;
//   final String pinCode;
//   final String status;
//   final String kycStatus;
//   final String? kycRejectionReason;
//   final String? deviceToken;
//
//   VendorData({
//     required this.id,
//     required this.vendorId,
//     required this.businessType,
//     required this.businessRegistrationName,
//     required this.email,
//     required this.phoneNo,
//     required this.website,
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.pinCode,
//     required this.status,
//     required this.kycStatus,
//     this.kycRejectionReason,
//     this.deviceToken,
//   });
//
//   factory VendorData.fromJson(Map<String, dynamic> json) {
//     return VendorData(
//       id: json['id'],
//       vendorId: json['vendor_id'],
//       businessType: json['business_type'],
//       businessRegistrationName: json['business_registration_name'],
//       email: json['email'],
//       phoneNo: json['phone_no'],
//       website: json['website'],
//       address: json['address'],
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       pinCode: json['pin_code'],
//       status: json['status'],
//       kycStatus: json['kyc_status'],
//       kycRejectionReason: json['kyc_rejection_reason'],
//       deviceToken: json['device_token'],
//     );
//   }
// }
//
// class UserData {
//   final int id;
//   final String userId;
//   final String? deviceToken;
//   final String name;
//   final String mobileNo;
//   final String dateOfBirth;
//   final String gender;
//   final String email;
//   final String dateTime;
//   final String image;
//   final String drinkingHabit;
//   final String smokingHabit;
//   final List<String> partyTypes;
//   final List<String> vibesImages;
//   final String status;
//   final String? socialMedia;
//   final String? influencerMode;
//   final String? myStyle;
//   final SocialMediaProfiles socialMediaProfiles;
//   final Address address;
//
//   UserData({
//     required this.id,
//     required this.userId,
//     this.deviceToken,
//     required this.name,
//     required this.mobileNo,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.email,
//     required this.dateTime,
//     required this.image,
//     required this.drinkingHabit,
//     required this.smokingHabit,
//     required this.partyTypes,
//     required this.vibesImages,
//     required this.status,
//     this.socialMedia,
//     this.influencerMode,
//     this.myStyle,
//     required this.socialMediaProfiles,
//     required this.address,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       id: json['id'],
//       userId: json['user_id'],
//       deviceToken: json['device_token'],
//       name: json['name'],
//       mobileNo: json['mobile_no'],
//       dateOfBirth: json['date_of_birth'],
//       gender: json['gender'],
//       email: json['email'],
//       dateTime: json['date_time'],
//       image: json['image'],
//       drinkingHabit: json['drinking_habbit'],
//       smokingHabit: json['smoking_habbit'],
//       partyTypes: List<String>.from(json['party_types']),
//       vibesImages: List<String>.from(json['vibes_images']),
//       status: json['status'],
//       socialMedia: json['socialMedia'],
//       influencerMode: json['InfluencerMode'],
//       myStyle: json['my_style'],
//       socialMediaProfiles: SocialMediaProfiles.fromJson(json['social_media_profiles']),
//       address: Address.fromJson(json['address']),
//     );
//   }
// }
//
// class SocialMediaProfiles {
//   final String? instagramProfile;
//   final String? facebookProfile;
//   final String? snapchatProfile;
//
//   SocialMediaProfiles({
//     this.instagramProfile,
//     this.facebookProfile,
//     this.snapchatProfile,
//   });
//
//   factory SocialMediaProfiles.fromJson(Map<String, dynamic> json) {
//     return SocialMediaProfiles(
//       instagramProfile: json['instagram_profile'],
//       facebookProfile: json['facebook_profile'],
//       snapchatProfile: json['snapchat_profile'],
//     );
//   }
// }
//
// class Address {
//   final String? houseNo;
//   final String? area;
//   final String? landmark;
//   final String? city;
//   final String? state;
//   final String? pincode;
//
//   Address({
//     this.houseNo,
//     this.area,
//     this.landmark,
//     this.city,
//     this.state,
//     this.pincode,
//   });
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       houseNo: json['house_no'],
//       area: json['area'],
//       landmark: json['landmark'],
//       city: json['city'],
//       state: json['state'],
//       pincode: json['pincode'],
//     );
//   }
// }







class BookingResponse {
  final String status;
  final List<BookingData> data;

  BookingResponse({required this.status, required this.data});

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => BookingData.fromJson(item))
          .toList() ??
          [],
    );
  }
}

class BookingData {
  final int id;
  final VendorData vendorData;
  final UserData userData;
  final String bookingDate;
  final String bookingDay;
  final String bookingId;
  final int? tableCount;
  final String? bookedTimeSlot;
  final String? bookedDate;

  BookingData({
    required this.id,
    required this.vendorData,
    required this.userData,
    required this.bookingDate,
    required this.bookingDay,
    required this.bookingId,
    this.tableCount,
    this.bookedTimeSlot,
    this.bookedDate,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'] ?? 0,
      vendorData: VendorData.fromJson(json['vendor_data'] ?? {}),
      userData: UserData.fromJson(json['user_data'] ?? {}),
      bookingDate: json['booking_date'] ?? '',
      bookingDay: json['booking_day'] ?? '',
      bookingId: json['booking_id'] ?? '',
      tableCount: json['table_count'],
      bookedTimeSlot: json['booked_time_slot'],
      bookedDate: json['booked_date'],
    );
  }
}

class VendorData {
  final int id;
  final String vendorId;
  final String businessType;
  final String businessRegistrationName;
  final String constitution;
  final String ownerName;
  final String email;
  final String phoneNo;
  final String website;
  final String address;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  final String status;
  final String kycStatus;
  final String? kycRejectionReason;
  final String? deviceToken;

  VendorData({
    required this.id,
    required this.vendorId,
    required this.businessType,
    required this.businessRegistrationName,
    required this.constitution,
    required this.ownerName,
    required this.email,
    required this.phoneNo,
    required this.website,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.status,
    required this.kycStatus,
    this.kycRejectionReason,
    this.deviceToken,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['id'] ?? 0,
      vendorId: json['vendor_id'] ?? '',
      businessType: json['business_type'] ?? '',
      businessRegistrationName: json['business_registration_name'] ?? '',
      constitution: json['constitution'] ?? '',
      ownerName: json['owner_name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pinCode: json['pin_code'] ?? '',
      status: json['status'] ?? '',
      kycStatus: json['kyc_status'] ?? '',
      kycRejectionReason: json['kyc_rejection_reason'],
      deviceToken: json['device_token'],
    );
  }
}

class UserData {
  final int id;
  final String userId;
  final String? deviceToken;
  final String name;
  final String mobileNo;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String dateTime;
  final String image;
  final String drinkingHabit;
  final String smokingHabit;
  final List<String> partyTypes;
  final List<String> vibesImages;
  final String status;
  final String? socialMedia;
  final String? influencerMode;
  final String? myStyle;
  final SocialMediaProfiles socialMediaProfiles;
  final Address address;
  final bool? membership;
  final String? membershipType;
  final String? planPurchasedDateTime;
  final String? planExpireDateTime;

  UserData({
    required this.id,
    required this.userId,
    this.deviceToken,
    required this.name,
    required this.mobileNo,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.dateTime,
    required this.image,
    required this.drinkingHabit,
    required this.smokingHabit,
    required this.partyTypes,
    required this.vibesImages,
    required this.status,
    this.socialMedia,
    this.influencerMode,
    this.myStyle,
    required this.socialMediaProfiles,
    required this.address,
    this.membership,
    this.membershipType,
    this.planPurchasedDateTime,
    this.planExpireDateTime,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      deviceToken: json['device_token'],
      name: json['name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      dateTime: json['date_time'] ?? '',
      image: json['image'] ?? '',
      drinkingHabit: json['drinking_habbit'] ?? '',
      smokingHabit: json['smoking_habbit'] ?? '',
      partyTypes: List<String>.from(json['party_types'] ?? []),
      vibesImages: List<String>.from(json['vibes_images'] ?? []),
      status: json['status'] ?? '',
      socialMedia: json['socialMedia'],
      influencerMode: json['InfluencerMode'],
      myStyle: json['my_style'],
      socialMediaProfiles:
      SocialMediaProfiles.fromJson(json['social_media_profiles'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      membership: json['membership'],
      membershipType: json['membership_type'],
      planPurchasedDateTime: json['plan_purchased_date_time'],
      planExpireDateTime: json['plan_expire_date_time'],
    );
  }
}

class SocialMediaProfiles {
  final String? instagramProfile;
  final String? facebookProfile;
  final String? snapchatProfile;

  SocialMediaProfiles({
    this.instagramProfile,
    this.facebookProfile,
    this.snapchatProfile,
  });

  factory SocialMediaProfiles.fromJson(Map<String, dynamic> json) {
    return SocialMediaProfiles(
      instagramProfile: json['instagram_profile'],
      facebookProfile: json['facebook_profile'],
      snapchatProfile: json['snapchat_profile'],
    );
  }
}

class Address {
  final String? houseNo;
  final String? area;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;

  Address({
    this.houseNo,
    this.area,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      houseNo: json['house_no'],
      area: json['area'],
      landmark: json['landmark'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
    );
  }
}
