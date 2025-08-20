import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import '../../../config/theme.dart';
import '../../admin_details/widget/custom_drop_down/custom_drop_down.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
import '../model/EventPostModel.dart';
import '../widget/artist_card.dart';
class EventAddArtists extends StatefulWidget {
  const EventAddArtists({super.key});
  @override
  State<EventAddArtists> createState() => _EventAddArtistsState();
}
class _EventAddArtistsState extends State<EventAddArtists> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.bookingAddArtistFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Artists To Your Event", style: context.titleLarge()),
              10.height(),
              Text(
                "Get discovered by the right crowd Post your event in minutes.",
                style: context.titleSmall(),
              ),
              20.height(),

              Wrap(children:EventController.artistDataList.map((item)=>
                  ArtistCard(name: item.artistName??'',
                      industry: item.artistCategory??"",
                      imageName: item.imgPath??'',
                      onEdit: (){}, onDelete: (){
                        setState(() {
                          EventController.artistDataList.remove(item);
                        });

                      }))
                  .toList(),),
              20.height(),
              CustomTextField(
                textController: EventController.artistNameController,
                title: "Artist Name",
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter Valid artist name";
                  }
                },
              ),
              20.height(),
              CustomDropDown(
                placeHolder: "choose artist category",
                title: "Artist Category",
                heading: "choose artist category",
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter Valid artist category";
                  }
                },
                controller: EventController.artistCategoryController,
                listCustomDropDownModel: [
                  CustomDropDownModel(name: "Bollywood"),
                  CustomDropDownModel(name: "Hollywood"),
                  CustomDropDownModel(name: "Music"),
                  CustomDropDownModel(name: "Pop Singer"),
                  CustomDropDownModel(name: "Rock"),
                  CustomDropDownModel(name: "Jazz"),
                  CustomDropDownModel(name: "Other"),
                ],
                onSelect: (CustomDropDownModel model) {},
              ),
              20.height(),
              CustomTextField(
                title: "About Artist",
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter About to artist";
                  }
                },
                placeHolderText: "100 Words Only",
                maxLines: 6,
                minLines: 6,
                textController: EventController.artistAboutController,
              ),
              20.height(),

              CustomFilePickerContainer(
                title: "Artist Photo",
                controller: EventController.artistPhotoController,
                validator: (String? data) {
                  if (data == AppStr.filePickerDefaultText) {
                    return "choose artist photo";
                  }
                },
              ),

              20.height(),

              Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: AppColors.black,
                  onPressed: () {
                    if (EventController.bookingAddArtistFormKey.currentState
                            ?.validate() ??
                        false) {

                      setState(() {
                        EventController.artistDataList.add(ArtistsModel(
                          artistName: EventController.artistNameController.text,
                          artistCategory: EventController.artistCategoryController.text,
                          aboutArtist: EventController.artistAboutController.text,
                          imgPath: EventController.artistPhotoController.text
                        ));
                  Future.delayed(Duration(seconds: 1),(){
                    EventController.artistNameController.clear();
                    EventController.artistCategoryController.clear();
                    EventController.artistPhotoController.text=AppStr.filePickerDefaultText;
                    EventController.artistAboutController.clear();
                  });
                      });
                    }else{
                      showToast("Add Valid Data");
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
