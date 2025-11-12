



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import '../../../../config/theme.dart';
// import '../../model/EventPostModel.dart';
//
// class EventView extends StatelessWidget {
//   const EventView({
//     super.key,
//     required this.getEventModel,
//     this.isDelete = true,
//     this.isEdit = true,
//   });
//
//   final EventPostModel getEventModel;
//   final bool isDelete, isEdit;
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('eventStatus....${getEventModel.status}');
//
//     final isUpcoming = (getEventModel.status?.toLowerCase().trim().contains("upcoming") ?? false);
//     final tickets = ticketStringToModel(getEventModel.ticketModelInString);
//     final ticketDisplay = tickets?.map((item) => '${item.ticketType} - \₹${item.price}').join(', ') ?? 'N/A';
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Event Name as Title
//                   Text(
//                     getEventModel.eventName ?? 'Untitled Event',
//
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Event Date with Icon
//                   _buildInfoRow(
//                     context,
//                     icon: Icons.calendar_today,
//                     label: 'Event Date',
//                     value: getEventModel.eventDate ?? 'TBD',
//                     valueColor: AppColors.green,
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Event Time with Icon
//                   _buildInfoRow(
//                     context,
//                     icon: Icons.access_time,
//                     label: 'Event Time',
//                     value: '${getEventModel.startTime ?? ''} - ${getEventModel.endTime ?? ''}',
//                     valueColor: AppColors.green,
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Venue with Icon
//                   _buildInfoRow(
//                     context,
//                     icon: Icons.location_on,
//                     label: 'Venue',
//                     value: _buildVenueText(),
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Ticket Price with Icon
//                   _buildInfoRow(
//                     context,
//                     icon: Icons.confirmation_number,
//                     label: 'Ticket Price',
//                     value: ticketDisplay,
//                     valueColor: AppColors.green,
//                   ),
//
//                 ],
//               ),
//               // Actions positioned at top-right
//               if (isUpcoming)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Column(
//                     children: [
//
//                       InkWell(
//                         onTap: (){
//
//                         },
//                         child: Container(
//                           width: 70,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: AppColors.themeColor,
//                           ),
//                           child: Text(textAlign: TextAlign.center,'Pause',style: TextStyle(fontSize: 14),),
//                         ),
//                       ),
//
//                       15.height(),
//
//                       InkWell(
//                         onTap: (){
//
//                         },
//                         child: Container(
//                           width: 70,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: AppColors.themeColor,
//                           ),
//                           child: Text(textAlign: TextAlign.center,'Update',style: TextStyle(fontSize: 14),),
//                         ),
//                       ),
//
//                       15.height(),
//                       InkWell(
//                         onTap: (){
//
//                         },
//                         child: Container(
//                           width: 70,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: AppColors.themeColor,
//                           ),
//                           child: Text(textAlign: TextAlign.center,'Delete',style: TextStyle(fontSize: 14),),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _buildVenueText() {
//     String venueText = '';
//     try {
//       final locationJson = jsonDecode(getEventModel.location ?? '{}');
//       venueText = '${locationJson['address'] ?? ''}, ${locationJson['city'] ?? ''}, ${locationJson['state'] ?? ''} ${locationJson['pinCode'] ?? ''}'.trim();
//       if (venueText.isEmpty) venueText = getEventModel.venue ?? '';
//     } catch (e) {
//       venueText = getEventModel.venue ?? '';
//     }
//     return venueText.isEmpty ? 'Venue TBD' : venueText;
//   }
//
//   Widget _buildInfoRow(
//       BuildContext context, {
//         required IconData icon,
//         required String label,
//         required String value,
//         Color? valueColor,
//       }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           icon,
//           size: 20,
//           color: AppColors.green,
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: TextStyle(
//                   color: valueColor ?? Colors.black87,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<TicketModel>? ticketStringToModel(String? rawString) {
//     List<TicketModel>? listTicketModel;
//     try {
//       print("$rawString");
//
//       List<dynamic> listDynamic = jsonDecode(rawString ?? '');
//       listTicketModel = listDynamic
//           .map((item) => TicketModel.fromJson(item))
//           .toList();
//       return listTicketModel;
//     } catch (exception) {
//       print("--$exception");
//       return null;
//     }
//   }
// }





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/event/bloc/event_post_bloc.dart';
import 'package:new_pubup_partner/features/event/event_update_booking.dart';
import '../../../../config/theme.dart';
import '../../model/EventPostModel.dart';


class EventView extends StatelessWidget {
  const EventView({
    super.key,
    required this.getEventModel,
    this.isDelete = true,
    this.isEdit = true,
  });

  final EventPostModel getEventModel;
  final bool isDelete, isEdit;

  @override
  Widget build(BuildContext context) {
    debugPrint('eventStatus....${getEventModel.status}');

    final isUpcoming = (getEventModel.status?.toLowerCase().trim().contains("upcoming") ?? false);
    final isPaused = getEventModel.isEventPause ?? false;
    final tickets = ticketStringToModel(getEventModel.ticketModelInString);
    final ticketDisplay = tickets?.map((item) => '${item.ticketType} - \₹${item.price}').join(', ') ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Event Name as Title
                  Text(
                    getEventModel.eventName ?? 'Untitled Event',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Event Date with Icon
                  _buildInfoRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Event Date',
                    value: getEventModel.eventDate ?? 'TBD',
                    valueColor: AppColors.green,
                  ),
                  const SizedBox(height: 12),

                  // Event Time with Icon
                  _buildInfoRow(
                    context,
                    icon: Icons.access_time,
                    label: 'Event Time',
                    value: '${getEventModel.startTime ?? ''} - ${getEventModel.endTime ?? ''}',
                    valueColor: AppColors.green,
                  ),
                  const SizedBox(height: 12),

                  // Venue with Icon
                  _buildInfoRow(
                    context,
                    icon: Icons.location_on,
                    label: 'Venue',
                    value: _buildVenueText(),
                  ),
                  const SizedBox(height: 12),

                  // Ticket Price with Icon
                  _buildInfoRow(
                    context,
                    icon: Icons.confirmation_number,
                    label: 'Ticket Price',
                    value: ticketDisplay,
                    valueColor: AppColors.green,
                  ),
                ],
              ),
              // Actions positioned at top-right
              if (isUpcoming)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (isPaused) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Already paused'),
                                backgroundColor: Colors.orange,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Theme.of(context).dialogBackgroundColor,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.pause_circle_outline,
                                          size: 64,
                                          color: AppColors.themeColor.withOpacity(0.7),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Pause Event',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Are you sure you want to pause this event?\nThis action can be reversed later if needed.',
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () => Navigator.of(dialogContext).pop(),
                                              child: const Text('Cancel'),
                                            ),
                                            const SizedBox(width: 12),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(dialogContext).pop();
                                                // Trigger bloc event
                                                context.read<EventPostBloc>().add(
                                                  EventPauseEvent(eventId: getEventModel.id! ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.themeColor,
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text('Pause Event'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isPaused ? Colors.grey : AppColors.themeColor,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            isPaused ? 'Paused' : 'Pause',
                            style: const TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),

                      15.height(),

                      InkWell(
                        onTap: () {
                          // TODO: Implement update action

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventUpdateBooking(existingEvent: getEventModel),
                            ),
                          );
                        },
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.themeColor,
                          ),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Update',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),

                      15.height(),
                      InkWell(
                        onTap: () {
                          // TODO: Implement delete action


                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).dialogBackgroundColor,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.delete_outline,
                                        size: 64,
                                        color: Colors.red.withOpacity(0.7),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Delete Event',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Are you sure you want to delete this event?\nThis action cannot be reversed.',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () => Navigator.of(dialogContext).pop(),
                                            child: const Text('Cancel'),
                                          ),
                                          const SizedBox(width: 12),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                              // Trigger bloc event
                                              context.read<EventPostBloc>().add(
                                                EventDeleteEvent(eventId: getEventModel.id!),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text('Delete Event'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );





                        },
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.themeColor,
                          ),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'Delete',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildVenueText() {
    String venueText = '';
    try {
      final locationJson = jsonDecode(getEventModel.location ?? '{}');
      venueText = '${locationJson['address'] ?? ''}, ${locationJson['city'] ?? ''}, ${locationJson['state'] ?? ''} ${locationJson['pinCode'] ?? ''}'.trim();
      if (venueText.isEmpty) venueText = getEventModel.venue ?? '';
    } catch (e) {
      venueText = getEventModel.venue ?? '';
    }
    return venueText.isEmpty ? 'Venue TBD' : venueText;
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        Color? valueColor,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.green,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<TicketModel>? ticketStringToModel(String? rawString) {
    List<TicketModel>? listTicketModel;
    try {
      print("$rawString");

      List<dynamic> listDynamic = jsonDecode(rawString ?? '');
      listTicketModel = listDynamic
          .map((item) => TicketModel.fromJson(item))
          .toList();
      return listTicketModel;
    } catch (exception) {
      print("--$exception");
      return null;
    }
  }
}