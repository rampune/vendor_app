class BusinessKycModel{
  final String? businessRegistrationName,
  constitution,
  gstNumber,panCard,fssaiLicense,vendorName;
  int ?businessType;
  BusinessKycModel({
     this.constitution,
    this.businessRegistrationName,
    this.businessType,
    this.fssaiLicense,
    this.gstNumber,
    this.panCard,
    this.vendorName

});
 factory BusinessKycModel.fromJson(Map<String,dynamic> mapData){
   return BusinessKycModel(
       businessType:mapData['businessType']
       ,businessRegistrationName:mapData['businessRegistrationName'],
       constitution:mapData['constitution'],
       gstNumber:mapData['gstNumber'],
       panCard:mapData['panCard'],
       vendorName: mapData['vendorName'],

       fssaiLicense:mapData['fssaiLicense']
   );
 }
 Map<String,dynamic> toJson(){
   return {"businessType":businessType,
   "businessRegistrationName":businessRegistrationName,
     "constitution":constitution,
     "gstNumber":gstNumber,"panCard":panCard,
   "fssaiLicense":fssaiLicense,
     "vendorName":vendorName
   };
 }


}