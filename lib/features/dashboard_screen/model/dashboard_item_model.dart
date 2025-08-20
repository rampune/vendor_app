class DashboardItemViewModel{
  String ?title;
  EventModel ?eventModel;
  DashboardItemViewModel({this.title,this.eventModel});
}

class EventModel{
  String? eventName,eventDate,value;
  double? price;
  EventModel({
    this.eventDate,this.eventName,this.price,this.value,

});

}