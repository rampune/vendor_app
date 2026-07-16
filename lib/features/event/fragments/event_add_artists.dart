

// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/common_functions.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import 'package:new_pubup_partner/config/string.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
// import '../../../config/theme.dart';
// import '../../admin_details/widget/custom_drop_down/custom_drop_down.dart';
// import '../../common_widgets/custom_button.dart';
// import '../../common_widgets/custom_text_field.dart';
// import '../event_controller/event_controller.dart';
// import '../model/EventPostModel.dart';
// import '../widget/artist_card.dart';
// import 'package:new_pubup_partner/features/event/load_save_event.dart';
// class EventAddArtists extends StatefulWidget {
//   const EventAddArtists({super.key});
//   @override
//   State<EventAddArtists> createState() => _EventAddArtistsState();
// }
// class _EventAddArtistsState extends State<EventAddArtists> with AutomaticKeepAliveClientMixin{
//   List<CustomDropDownModel> artistCategories = [
//     CustomDropDownModel(name: "Bollywood"),
//     CustomDropDownModel(name: "Hollywood"),
//     CustomDropDownModel(name: "Music"),
//     CustomDropDownModel(name: "Pop Singer"),
//     CustomDropDownModel(name: "Rock"),
//     CustomDropDownModel(name: "Jazz"),
//     CustomDropDownModel(name: "Other"),
//   ];
//
//   bool _validateArtistFields() {
//     if (EventController.artistNameController.text.trim().isEmpty) {
//       showToast("Enter Artist Name");
//       return false;
//     }
//     if (EventController.artistCategoryController.text.trim().isEmpty) {
//       showToast("Choose Artist Category");
//       return false;
//     }
//     if (EventController.artistAboutController.text.trim().isEmpty) {
//       showToast("Enter About Artist");
//       return false;
//     }
//     if (EventController.artistPhotoController.text == AppStr.filePickerDefaultText) {
//       showToast("Choose Artist Photo");
//       return false;
//     }
//     return true;
//   }
//
//   void _addArtistAndClear() {
//     if (!_validateArtistFields()) {
//       return;
//     }
//     ArtistsModel artistModel = ArtistsModel(
//         artistName: EventController.artistNameController.text,
//         artistCategory: EventController.artistCategoryController.text,
//         aboutArtist: EventController.artistAboutController.text,
//         imgPath: EventController.artistPhotoController.text
//     );
//     EventController.artistDataList.add(artistModel);
//     // Clear fields
//     EventController.artistNameController.clear();
//     EventController.artistCategoryController.clear();
//     EventController.artistPhotoController.text = AppStr.filePickerDefaultText;
//     EventController.artistAboutController.clear();
//     LoadSaveEvent.instance.saveEventToHive();
//     setState(() {});
//   }
//
//   void _addArtistAndNext() {
//     hideKeyboard();
//     LoadSaveEvent.instance.saveEventToHive();
//     if (EventController.artistNameController.text.trim().isNotEmpty) {
//       if (!_validateArtistFields()) {
//         return;
//       }
//       ArtistsModel artistModel = ArtistsModel(
//           artistName: EventController.artistNameController.text,
//           artistCategory: EventController.artistCategoryController.text,
//           aboutArtist: EventController.artistAboutController.text,
//           imgPath: EventController.artistPhotoController.text
//       );
//       EventController.artistDataList.add(artistModel);
//       // Clear fields
//       EventController.artistNameController.clear();
//       EventController.artistCategoryController.clear();
//       EventController.artistPhotoController.text = AppStr.filePickerDefaultText;
//       EventController.artistAboutController.clear();
//     }
//     // Move to next regardless
//     EventController.eventPageController.animateToPage(
//       6,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: SingleChildScrollView(
//         child: Form(
//           key: EventController.bookingAddArtistFormKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Add Artists To Your Event", style: context.titleLarge()),
//               10.height(),
//               Text(
//                 "Get discovered by the right crowd Post your event in minutes.",
//                 style: context.titleSmall(),
//               ),
//               20.height(),
//
//               Wrap(children:EventController.artistDataList.map((item)=>
//                   ArtistCard(name: item.artistName??'',
//                       industry: item.artistCategory??"",
//                       imageName: item.imgPath??'',
//                       onEdit: (){}, onDelete: (){
//                         setState(() {
//                           EventController.artistDataList.remove(item);
//                         });
//
//                       }))
//                   .toList(),),
//               20.height(),
//               CustomTextField(
//                 // Removed validator
//                 textController: EventController.artistNameController,
//                 title: "Artist Name",
//               ),
//               20.height(),
//               CustomDropDown(
//                 placeHolder: "choose artist category",
//                 title: "Artist Category",
//                 heading: "choose artist category",
//                 // Removed validator
//                 controller: EventController.artistCategoryController,
//                 listCustomDropDownModel: artistCategories,
//                 onSelect: (CustomDropDownModel model) {
//                   EventController.artistCategoryController.text = model.name;
//                 },
//               ),
//               20.height(),
//               CustomTextField(
//                 title: "About Artist",
//                 // Removed validator
//                 placeHolderText: "100 Words Only",
//                 maxLines: 6,
//                 minLines: 6,
//                 textController: EventController.artistAboutController,
//               ),
//               20.height(),
//
//               CustomFilePickerContainer(
//                 title: "Artist Photo",
//                 controller: EventController.artistPhotoController,
//                 // Removed validator
//               ),
//
//               20.height(),
//               Text(
//                 "If you have multiple artists",
//                 style: const TextStyle(color: Colors.red),
//               ),
//               10.height(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       buttonColor: AppColors.black,
//                       buttonText: "+ Add More Artists",
//                       onPress: _addArtistAndClear,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: CustomButton(
//                       buttonColor: Colors.amber,
//                       buttonText: "Next",
//                       onPress: _addArtistAndNext,
//                     ),
//                   ),
//                 ],
//               ),
//               20.height(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/event/bloc/artist_bloc.dart';
import 'package:new_pubup_partner/features/event/event_controller/event_controller.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';
import 'package:new_pubup_partner/features/event/model/artist_model.dart';
import 'package:new_pubup_partner/features/event/widget/artist_card.dart';
import '../../../config/theme.dart';
import '../../admin_details/widget/custom_drop_down/custom_drop_down.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';

class EventAddArtists extends StatefulWidget {
  const EventAddArtists({super.key});

  // ==============================================
  // STATIC SET TO HOLD SELECTED ARTIST IDs
  // ==============================================
  static final Set<int> selectedArtistIds = <int>{};

  // ==============================================
  // STATIC METHODS — NOW PROPERLY PLACED!
  // ==============================================
  static List<int> getSelectedArtistIds() => selectedArtistIds.toList();

  static void restoreSelectedArtistIds(List<int> ids) {
    selectedArtistIds.clear();
    selectedArtistIds.addAll(ids.where((id) => id > 0));
  }

  static void clearSelectedArtistIds() {
    selectedArtistIds.clear();
  }

  @override
  State<EventAddArtists> createState() => _EventAddArtistsState();
}

class _EventAddArtistsState extends State<EventAddArtists> with AutomaticKeepAliveClientMixin {
  final List<CustomDropDownModel> artistCategories = [
    CustomDropDownModel(name: "Bollywood"),
    CustomDropDownModel(name: "Hollywood"),
    CustomDropDownModel(name: "Music"),
    CustomDropDownModel(name: "Pop Singer"),
    CustomDropDownModel(name: "Rock"),
    CustomDropDownModel(name: "Jazz"),
    CustomDropDownModel(name: "Other"),
  ];

  String? _pendingNewArtistName;

  final ValueNotifier<Set<int>> selectedIdsNotifier = ValueNotifier(EventAddArtists.selectedArtistIds);

  @override
  void initState() {
    super.initState();
    // Ensure the notifier is synced with the current static state
    selectedIdsNotifier.value = {...EventAddArtists.selectedArtistIds};
  }

  void _clearArtistForm() {
    EventController.artistNameController.clear();
    EventController.artistCategoryController.clear();
    EventController.artistAboutController.clear();
    EventController.artistPhotoController.text = AppStr.filePickerDefaultText;
    EventController.artistPhotoFile = null;
    _pendingNewArtistName = null;
  }

  bool _validateArtistFields() {
    if (EventController.artistNameController.text.trim().isEmpty) {
      showToast("Enter Artist Name");
      return false;
    }
    if (EventController.artistCategoryController.text.trim().isEmpty) {
      showToast("Choose Artist Category");
      return false;
    }
    if (EventController.artistAboutController.text.trim().isEmpty) {
      showToast("Enter About Artist");
      return false;
    }
    if (EventController.artistPhotoController.text == AppStr.filePickerDefaultText ||
        EventController.artistPhotoFile == null) {
      showToast("Choose Artist Photo");
      return false;
    }
    return true;
  }

  void _addArtistAndNext() {
    hideKeyboard();
    LoadSaveEvent.instance.saveEventToHive();
    EventController.eventPageController.animateToPage(
      6,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _addNewArtistToEvent(BuildContext blocContext) {
    if (!_validateArtistFields()) return;

    _pendingNewArtistName = EventController.artistNameController.text.trim();

    final file = EventController.artistPhotoFile!;
    final imageUploadModel = ImageUploadModel(fileName: "artist_image", file: file);

    final Map<String, dynamic> artistData = {
      "artist_name": _pendingNewArtistName,
      "artist_category": EventController.artistCategoryController.text.trim(),
      "about_artist": EventController.artistAboutController.text.trim(),
    };

    blocContext.read<ArtistBloc>().add(AddArtistEvent(data: artistData, image: imageUploadModel));
  }

  void _toggleArtistSelection(int artistId) {
    setState(() {
      if (EventAddArtists.selectedArtistIds.contains(artistId)) {
        EventAddArtists.selectedArtistIds.remove(artistId);
        showToast("Artist removed");
      } else {
        EventAddArtists.selectedArtistIds.add(artistId);
        showToast("Artist added!");
      }
      selectedIdsNotifier.value = {...EventAddArtists.selectedArtistIds};
    });
  }



  void _openExistingArtistsDialog(BuildContext blocContext) {
    final searchController = TextEditingController();
    final ValueNotifier<String> searchQuery = ValueNotifier<String>('');

    searchController.addListener(() {
      searchQuery.value = searchController.text.toLowerCase();
    });

    showDialog(
      context: blocContext,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: MediaQuery.of(blocContext).size.width * 0.9,
            height: MediaQuery.of(blocContext).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select from Existing Artists",
                        style: Theme.of(blocContext).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(dialogContext)),
                  ],
                ),
                10.height(),
                const Divider(),
                15.height(),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 14),
                    hintText: "Search by name or category...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(icon: const Icon(Icons.clear), onPressed: searchController.clear)
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                15.height(),

                Expanded(
                  child: ValueListenableBuilder<Set<int>>(
                    valueListenable: selectedIdsNotifier,
                    builder: (context, selectedIds, child) {
                      return BlocBuilder<ArtistBloc, ArtistState>(
                        bloc: blocContext.read<ArtistBloc>(),
                        builder: (ctx, state) {
                          if (state is ArtistLoadingState) return const Center(child: CircularProgressIndicator());
                          if (state is ArtistErrorState) return Center(child: Text("Error: ${state.message}"));

                          if (state is ArtistLoadedState && state.artists.isNotEmpty) {
                            return ValueListenableBuilder<String>(
                              valueListenable: searchQuery,
                              builder: (context, query, _) {
                                final filtered = state.artists.where((a) =>
                                a.artistName.toLowerCase().contains(query) ||
                                    a.artistCategory.toLowerCase().contains(query)).toList();

                                if (filtered.isEmpty) return const Center(child: Text("No artists found"));

                                return ListView.builder(
                                  itemCount: filtered.length,
                                  itemBuilder: (_, index) {
                                    final artist = filtered[index];
                                    final imgUrl = artist.artistImage.startsWith('http')
                                        ? artist.artistImage
                                        : '${EndPoints.baseUrl}${artist.artistImage}';
                                    final isSelected = selectedIds.contains(artist.id); // ← Live update!

                                    return Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      child: ListTile(
                                        leading: CircleAvatar(radius: 25, backgroundImage: NetworkImage(imgUrl)),
                                        title: Text(artist.artistName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        subtitle: Text(artist.artistCategory, style: const TextStyle(fontSize: 14)),
                                        trailing: AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          child: isSelected
                                              ? const Icon(Icons.check_circle, key: ValueKey('check'), color: Colors.green, size: 30)
                                              : IconButton(
                                            key: const ValueKey('add'),
                                            icon: const Icon(Icons.add_circle, color: Colors.green, size: 34),
                                            onPressed: () => _toggleArtistSelection(artist.id),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return const Center(child: Text("No artists available"));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<ArtistBloc>(
      create: (_) => ArtistBloc()..add(FetchArtistsEvent()),
      child: Builder(builder: (blocContext) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener<ArtistBloc, ArtistState>(
                  listener: (context, state) {
                    if (state is ArtistAddedSuccessState) {
                      showToast("New artist added & selected!");
                    }

                    if (state is ArtistLoadedState && _pendingNewArtistName != null) {
                      final nameToMatch = _pendingNewArtistName!.toLowerCase();
                      final newArtist = state.artists.firstWhere(
                            (a) => a.artistName.toLowerCase() == nameToMatch,
                        orElse: () => state.artists.last,
                      );

                      if (newArtist.id != null && !EventAddArtists.selectedArtistIds.contains(newArtist.id)) {
                        setState(() {
                          EventAddArtists.selectedArtistIds.add(newArtist.id!);
                        });
                      }
                      _clearArtistForm();
                    }

                    if (state is ArtistErrorState) {
                      showToast("Error: ${state.message}");
                      _pendingNewArtistName = null;
                    }
                  },
                  child: const SizedBox.shrink(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Artists To Your Event", style: context.titleLarge()),
                    TextButton(
                      onPressed: _addArtistAndNext,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                10.height(),
                Text("Get discovered by the right crowd. Post your event in minutes.", style: context.titleSmall()),
                30.height(),

                // Selected Artists Cards
                BlocBuilder<ArtistBloc, ArtistState>(
                  builder: (context, state) {
                    if (state is ArtistLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is! ArtistLoadedState || state.artists.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text("No artists selected yet")),
                      );
                    }

                    final selectedArtists = state.artists
                        .where((a) => a.id != null && EventAddArtists.selectedArtistIds.contains(a.id))
                        .toList();

                    if (selectedArtists.isEmpty) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text("No artists selected yet", style: TextStyle(color: Colors.grey[500])),
                      );
                    }

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: selectedArtists.map((artist) {
                        final imgUrl = artist.artistImage.startsWith('http')
                            ? artist.artistImage
                            : '${EndPoints.baseUrl}${artist.artistImage}';

                        return ArtistCard(
                          name: artist.artistName,
                          industry: artist.artistCategory,
                          imageName: imgUrl,
                          onDelete: () {
                            setState(() => EventAddArtists.selectedArtistIds.remove(artist.id));
                            showToast("Artist removed");
                          },
                          onEdit: () {},
                        );
                      }).toList(),
                    );
                  },
                ),
                20.height(),

                // Horizontal preview
                BlocBuilder<ArtistBloc, ArtistState>(
                  builder: (ctx, state) {
                    if (state is ArtistLoadingState) {
                      return const SizedBox(height: 90, child: Center(child: CircularProgressIndicator()));
                    }
                    if (state is ArtistLoadedState && state.artists.isNotEmpty) {
                      return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.artists.length,
                          itemBuilder: (_, index) {
                            final artist = state.artists[index];
                            final imgUrl = artist.artistImage.startsWith('http')
                                ? artist.artistImage
                                : '${EndPoints.baseUrl}${artist.artistImage}';

                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  CircleAvatar(radius: 25, backgroundImage: NetworkImage(imgUrl)),
                                  6.height(),
                                  SizedBox(
                                    width: 70,
                                    child: Text(
                                      artist.artistName.length > 10
                                          ? "${artist.artistName.substring(0, 10)}..."
                                          : artist.artistName,
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                20.height(),
                CustomButton(
                  buttonText: 'Select from Existing Artist',
                  onPress: () => _openExistingArtistsDialog(blocContext),
                ),

                30.height(),
                const Center(child: Text("Or", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                20.height(),
                const Divider(),
                const Text("Add New Artist", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                20.height(),

                CustomTextField(textController: EventController.artistNameController, title: "Artist Name"),
                20.height(),
                CustomDropDown(
                  placeHolder: "Choose category",
                  title: "Artist Category",
                  controller: EventController.artistCategoryController,
                  listCustomDropDownModel: artistCategories,
                  onSelect: (m) => EventController.artistCategoryController.text = m.name,
                ),
                20.height(),
                CustomTextField(title: "About Artist", maxLines: 6, textController: EventController.artistAboutController),
                20.height(),
                CustomFilePickerContainer(title: "Artist Photo", controller: EventController.artistPhotoController),
                40.height(),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonColor: AppColors.black,
                        buttonText: "+ Add New Artist",
                        isLoading: blocContext.watch<ArtistBloc>().state is ArtistLoadingState,
                        onPress: () => _addNewArtistToEvent(blocContext),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        buttonColor: Colors.amber,
                        buttonText: "Next",
                        onPress: _addArtistAndNext,
                      ),
                    ),
                  ],
                ),
                50.height(),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

