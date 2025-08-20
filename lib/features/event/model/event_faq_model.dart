import 'dart:convert';

import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';

class EventFaqModel{
static saveFaq({required String key,required bool value}){
  try {
    print("${jsonEncode(listEventFaqModel)}");
    MyHiveBox.instance.getBox().put(AppStr.saveFaq, jsonEncode(loadFaq()
        .map((item) =>
    item.question == key ? EventFaqModel(
        question: item.question, answer: value, isFaq: item.isFaq) : item)
        .toList()));
  }catch(exception){
    print("$exception");
  }
  }
static List<EventFaqModel> loadFaq(){
try {
  String ?faqString = MyHiveBox.instance.getBox().get(AppStr.saveFaq);
  print("----- $faqString");
  if (faqString == null) {
    return listEventFaqModel;
  } else {
    List<dynamic> listDynamic = jsonDecode(faqString);
    List<EventFaqModel> listEventFaq = listDynamic.map((item) =>
        EventFaqModel.fromJson(item)).toList();
    return listEventFaq;
  }
}catch(exception){
  print("exception $exception");
  return [];
}
}
  static List<EventFaqModel> listEventFaqModel=
  [
    EventFaqModel(question: "Seating Arrangement", answer: false,isFaq: false),
    EventFaqModel(question: "Kids Friendly", answer: false,isFaq: false),
    EventFaqModel(question: "Pet Friendly", answer: false,isFaq: false),
    EventFaqModel(question: "1. Is re-entry Into the venue allowed", answer: false),
    EventFaqModel(question: "2. Can i get refund if i can't attend the event", answer: false),
    EventFaqModel(question: "3. Will food available at the venue", answer: false),
    EventFaqModel(question: "4. Will Alcohol be available at the venue", answer: false),
    EventFaqModel(question: "5. Is the venue wheelchair accessible", answer: false),
    EventFaqModel(question: "6. Restroom facility available", answer: false),
    EventFaqModel(question: "7. Is there designated smoking area", answer: false),
  ];
  String question;
  bool answer;
  bool isFaq;
  EventFaqModel({required this.question,required this.answer,this.isFaq=true});

  factory EventFaqModel.fromJson(Map<String,dynamic> data){
    return EventFaqModel(question: data["question"],answer: data["answer"],isFaq: data['isFaq']);
  }

  toJson(){

    return {"question":question,"answer":answer,"isFaq":isFaq};
  }
}

