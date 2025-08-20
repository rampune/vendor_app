// class TicketModel {
//   String? titleType;
//   int? price;
//   String? description;
//   bool? isFree;
//   String? coverCharges;
//   TicketModel({
//     this.titleType,
//     this.price,
//     this.coverCharges,
//     this.description,
//     this.isFree,
//   });
//   factory TicketModel.fromJson(Map<String, dynamic> mapData) {
//     return TicketModel(
//       titleType: mapData['ticket_type'],
//       price: mapData['price'],
//       description: mapData['description'],
//       isFree: mapData['is_free'],
//       coverCharges: mapData['cover_charges']
//     );
//   }
//
//   toJson() {
//     return {
//       "ticket_type": titleType,
//       "price": price,
//       "description":description,
//     "is_free":isFree,
//      "cover_charges" :coverCharges
//     };
//   }
// }
