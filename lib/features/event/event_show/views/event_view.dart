import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/event/bloc/event_post_bloc.dart';
import 'package:new_pubup_partner/features/event/event_update_booking.dart';
import 'package:new_pubup_partner/features/event/event_show/views/event_details_screen.dart';
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
    final isUpcoming = (getEventModel.status?.toLowerCase().trim().contains("upcoming") ?? false);
    final isPaused = getEventModel.isEventPause ?? false;
    final isCancelled = getEventModel.isEventCancel ?? false;
    final tickets = _parseTickets(getEventModel.ticketModelInString);
    final minPrice = tickets?.fold<int?>(null, (min, t) => (min == null || (t.price ?? 0) < min) ? t.price : min);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: getEventModel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & Status Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Hero(
                    tag: 'event_image_${getEventModel.id}',
                    child: (getEventModel.bannerImg != null && getEventModel.bannerImg!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: getEventModel.bannerImg!.startsWith('http') 
                                ? getEventModel.bannerImg! 
                                : 'https://adminapi.perseverancetechnologies.com${getEventModel.bannerImg!.startsWith('/') ? '' : '/'}${getEventModel.bannerImg!}',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => _buildPlaceholder(),
                            errorWidget: (context, url, error) => _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  ),
                ),
                // Status Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCancelled
                          ? Colors.red
                          : (isUpcoming ? AppColors.green : Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isCancelled
                          ? 'CANCELLED'
                          : (isUpcoming 
                              ? (isPaused ? 'PAUSED' : 'UPCOMING') 
                              : 'COMPLETED'),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Price Badge
                if (minPrice != null)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'From ₹$minPrice',
                        style: TextStyle(color: AppColors.themeColor, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          getEventModel.eventName ?? 'Untitled Event',
                          style: GoogleFonts.workSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isUpcoming && isEdit)
                        IconButton(
                          icon: Icon(Icons.edit_note, color: AppColors.themeColor, size: 28),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventUpdateBooking(existingEvent: getEventModel),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Date and Time
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        '${getEventModel.eventDate ?? "TBD"} • ${getEventModel.startTime ?? "TBD"}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Venue
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          getEventModel.venue ?? 'Venue TBD',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Bottom Actions (Pause/Delete/Cancel)
                  if (isUpcoming && !isCancelled) ...[
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: isPaused ? 'Resume' : 'Pause',
                            icon: isPaused ? Icons.play_arrow : Icons.pause,
                            color: isPaused ? Colors.blue : Colors.orange,
                            onTap: () => _handlePause(context),
                          ),
                        ),
                        10.width(),
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: 'Delete',
                            icon: Icons.delete_outline,
                            color: Colors.red,
                            onTap: () => _handleDelete(context),
                          ),
                        ),
                        10.width(),
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: 'Cancel',
                            icon: Icons.cancel_outlined,
                            color: Colors.red,
                            onTap: () => _handleCancel(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey[100],
      child: Icon(Icons.image_outlined, size: 48, color: Colors.grey[400]),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  void _handlePause(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(getEventModel.isEventPause == true ? 'Resume Event' : 'Pause Event'),
        content: Text('Are you sure you want to ${getEventModel.isEventPause == true ? 'resume' : 'pause'} this event?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<EventPostBloc>().add(
                EventPauseEvent(
                  eventId: getEventModel.id!,
                  isPaused: !(getEventModel.isEventPause ?? false),
                ),
              );
            },
            child: Text(getEventModel.isEventPause == true ? 'Resume' : 'Pause'),
          ),
        ],
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Event', style: TextStyle(color: Colors.red)),
        content: const Text('This action is permanent and cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<EventPostBloc>().add(
                EventDeleteEvent(eventId: getEventModel.id!),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _handleCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Event', style: TextStyle(color: Colors.red)),
        content: const Text('Are you sure you want to cancel this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<EventPostBloc>().add(
                EventCancelEvent(
                  eventId: getEventModel.id!,
                  isCancelled: true,
                ),
              );
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  List<TicketModel>? _parseTickets(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => TicketModel.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }
}