// class EventTableModel {
//   String? numberOfTable;
//   String? settingCapacity;
//   String? tablePrice;
//   String? coverCharges;
//
//   EventTableModel({
//     this.coverCharges,
//     this.numberOfTable,
//     this.settingCapacity,
//     this.tablePrice,
//   } );
//
//   // Named constructor: fromJson
//   EventTableModel.fromJson(Map<String, dynamic> json) {
//     numberOfTable = json['number_of_table']?.toString();
//     settingCapacity = json['setting_capacity']?.toString();
//     tablePrice = json['table_price']?.toString();
//     coverCharges = json['cover_charges']?.toString();
//   }
//
//   // Method: toJson
//   Map<String, dynamic> toJson() {
//     return {
//       'number_of_table': numberOfTable,
//       'setting_capacity': settingCapacity,
//       'table_price': tablePrice,
//       'cover_charges': coverCharges,
//     };
//   }
// }
