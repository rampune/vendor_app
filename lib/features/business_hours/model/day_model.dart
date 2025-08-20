class DayModel{
  static List<DayModel> dayModelList=[

    DayModel(day: "Sunday"),
    DayModel(day: "Monday"),
    DayModel(day: "Tuesday"),
    DayModel(day: "Wednesday"),
    DayModel(day: "Thursday"),
    DayModel(day: "Friday"),
    DayModel(day: "Saturday"),





  ];
  
  String day;
  bool isOpen;
  DayModel({required this.day,this.isOpen=false});
}