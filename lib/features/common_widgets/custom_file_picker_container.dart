// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import 'package:new_pubup_partner/config/string.dart';
//
//
// import '../../config/common_functions.dart';
// import '../../config/theme.dart' show AppColors;
// import '../../utils/pickers/pickers.dart';
// import '../../utils/save_and_retrive_file.dart';
// class CustomFilePickerContainer extends StatefulWidget {
//   const CustomFilePickerContainer({super.key,
//   required this.title, required this.controller,this.titleBold,this.validator});
// final String title;
// final bool ?titleBold;
// final TextEditingController controller;
// final String? Function(String?) ?validator;
//
//   @override
//   State<CustomFilePickerContainer> createState() => _CustomFilePickerContainerState();
// }
//
// class _CustomFilePickerContainerState extends State<CustomFilePickerContainer> {
//   @override
//   Widget build(BuildContext context) {
//
//     if(widget.controller.text.isEmpty){
//       widget.controller.text=AppStr.filePickerDefaultText;
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title,style:context.titleSmall()?.copyWith(
//           fontWeight: widget.titleBold!=null?FontWeight.bold:null
//         ) ,),
//         12.height(),
//         DottedBorder(
//           options: RectDottedBorderOptions(
//             color: AppColors.darkGray,
//             dashPattern: [5, 5],
//             strokeWidth: 1.5,
//             padding: EdgeInsets.all(10),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: AppColors.white
//             ),
//             child: Row(
//               children: [
//                 5.width(),
//                 Icon(Icons.backup_outlined),
//                 10.width(),
//                 Expanded(
//                   child:
//                   TextFormField(
//
//                     onTap: (){
//                       AppPickers.showFilePickerOption(context,
//                               (File ?file){
//
//                             final int fileSize = file?.lengthSync()??0; // in bytes
//                             if (fileSize <= 3*1024 * 1024) {
//
//                               String?  fileName=file?.path.split('/').last;
//                               saveFile(fileName: fileName??'',file: file);
//                               widget.controller.text=fileName??'';
//                               setState(() {
//
//                               });
//
//                             } else {
//                               showToast("File is larger than 1MB");
//                             }
//
//
//
//                           });
//                     },
//                     validator: widget.validator,
//                     maxLines: 2,
//                     controller: widget.controller,
//                     readOnly: true,
//                     style: context.bodySmall()?.copyWith(
//                         color:widget.controller.text==AppStr.filePickerDefaultText? AppColors.redLight:AppColors.darkGray
//                     ),
//                     decoration: InputDecoration(
//
//                         enabledBorder:OutlineInputBorder(
//
//                           borderSide: BorderSide(color: AppColors.transparent),
//
//
//                         ) ,
//                         focusedErrorBorder: OutlineInputBorder(
//
//                           borderSide: BorderSide(color: AppColors.transparent),
//
//
//                         ),
//                         errorBorder:OutlineInputBorder(
//
//                             borderSide: BorderSide(color: AppColors.transparent)),
//
//
//
//
//                         focusedBorder:OutlineInputBorder(
//
//                           borderSide: BorderSide(color: AppColors.transparent),
//
//                         ) ,
//                         border: OutlineInputBorder(
//
//                           borderSide: BorderSide(color: AppColors.transparent),
//
//                         )
//                     ),
//
//                   ),
//
//                 )
//
//               ],
//             ),
//           ),
//         )
//
//       ],
//     );
//   }
// }






import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/theme.dart' show AppColors;
import 'package:new_pubup_partner/utils/pickers/pickers.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';

// ADD THIS IMPORT (very important)
import 'package:new_pubup_partner/features/event/event_controller/event_controller.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/pub_cafe_gallery_controller.dart';

class CustomFilePickerContainer extends StatefulWidget {
  const CustomFilePickerContainer({
    super.key,
    required this.title,
    required this.controller,
    this.titleBold,
    this.validator,
  });

  final String title;
  final bool? titleBold;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomFilePickerContainer> createState() => _CustomFilePickerContainerState();
}

class _CustomFilePickerContainerState extends State<CustomFilePickerContainer> {
  File? _localFile;

  @override
  void initState() {
    super.initState();
    // Set default text only once if empty
    if (widget.controller.text.isEmpty) {
      widget.controller.text = AppStr.filePickerDefaultText;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.titleSmall()?.copyWith(
            fontWeight: widget.titleBold == true ? FontWeight.bold : null,
          ),
        ),
        12.height(),
        DottedBorder(
          options: RectDottedBorderOptions(
            color: AppColors.darkGray,
            dashPattern: [5, 5],
            strokeWidth: 1.5,
            padding: EdgeInsets.all(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, color: AppColors.darkGray),
                  10.width(),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      readOnly: true,
                      maxLines: 2,
                      validator: widget.validator,
                      style: context.bodySmall()?.copyWith(
                        color: widget.controller.text == AppStr.filePickerDefaultText
                            ? AppColors.redLight
                            : AppColors.darkGray,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () async {
                        AppPickers.showFilePickerOption(
                          context,
                              (File? pickedFile) async {
                            if (pickedFile == null) return;

                            final int fileSizeInBytes = await pickedFile.length();
                            const int maxSize = 5 * 1024 * 1024; // 5 MB (increased for images)

                            if (fileSizeInBytes > maxSize) {
                              showToast("File size must be less than 5MB");
                              return;
                            }

                            // Extract filename
                            final String fileName = pickedFile.path.split('/').last;

                            // Save file locally if needed
                            await saveFile(fileName: fileName, file: pickedFile);

                            // Update controller text
                            widget.controller.text = fileName;
                            _localFile = pickedFile;

                            // THIS IS THE MOST IMPORTANT PART:
                            // Save the actual File object based on which picker is using this
                            // Since this widget is used in multiple places, we handle common cases:

                            // For Artist Photo
                            if (widget.title.contains("Artist Photo") ||
                                widget.controller == EventController.artistPhotoController) {
                              EventController.artistPhotoFile = pickedFile;
                              EventController.artistPhotoController.text = fileName;
                            }

                            // You can add more cases here if used elsewhere
                            // Example:
                            // if (widget.title.contains("Banner")) {
                            //   EventController.bannerFile = pickedFile;
                            // }

                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  if (widget.controller.text != AppStr.filePickerDefaultText &&
                      widget.controller.text.isNotEmpty) ...[
                    _buildImagePreview(),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.red),
                      onPressed: () {
                        widget.controller.text = AppStr.filePickerDefaultText;
                        _localFile = null;

                        // Clear the saved file too
                        if (widget.title.contains("Artist Photo") ||
                            widget.controller == EventController.artistPhotoController) {
                          EventController.artistPhotoFile = null;
                        }

                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _resolveImageUrl(String path) {
    String cleanPath = path.trim();

    // Replace local development server hostnames/IPs with the production domain
    if (cleanPath.contains('127.0.0.1:8000')) {
      cleanPath = cleanPath.replaceAll('http://127.0.0.1:8000', 'https://adminapi.perseverancetechnologies.com');
    } else if (cleanPath.contains('localhost:8000')) {
      cleanPath = cleanPath.replaceAll('http://localhost:8000', 'https://adminapi.perseverancetechnologies.com');
    }

    // Replace media/gallery/ with gallery/
    if (cleanPath.contains('media/gallery/')) {
      cleanPath = cleanPath.replaceAll('media/gallery/', 'gallery/');
    }

    // If it's already a full URL, return it
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }

    // Determine the folder based on the title or controller if it doesn't already contain a folder slash
    if (!cleanPath.contains('/')) {
      String folder = '';
      final t = widget.title.toLowerCase();
      
      final isGallery = t.contains('gallery') ||
          widget.controller == PubCafeGalleryController.pubCafe1PhotoController ||
          widget.controller == PubCafeGalleryController.pubCafe2DrinkPhotoController ||
          widget.controller == PubCafeGalleryController.pubCafe3PhotoController ||
          widget.controller == PubCafeGalleryController.pubCafe4PhotoController;

      if (t == 'food' || t == 'drinks' || t == 'snacks' || t == 'other' || t == 'usp' || t.contains('menu')) {
        folder = 'menu/';
      } else if (t.contains('cheque')) {
        folder = 'media/cancelled_cheque/';
      } else if (t.contains('logo')) {
        folder = 'media/logo/';
      } else if (t.contains('business photo') || t.contains('business_photo')) {
        folder = 'media/business_photo/';
      } else if (t.contains('registration proof') || t.contains('registration_proof')) {
        folder = 'media/business_registration_proof/';
      } else if (t.contains('gst') || t.contains('gst_certificate')) {
        folder = 'media/gst_certificate/';
      } else if (t.contains('pan') || t.contains('pan_card')) {
        folder = 'media/pan_card_file/';
      } else if (t.contains('fssai') || t.contains('fssai_license')) {
        folder = 'media/fssai_license_file/';
      } else if (t.contains('artist photo') || t.contains('artist_photo')) {
        folder = 'media/artist_photo/';
      } else if (t.contains('venue layout') || t.contains('layout')) {
        folder = 'media/event_layout/';
      } else if (t.contains('banner')) {
        folder = 'media/event_banner/';
      } else if (isGallery) {
        folder = 'gallery/';
      }
      
      cleanPath = '$folder$cleanPath';
    }

    // Otherwise, prepend production base URL
    final base = 'https://adminapi.perseverancetechnologies.com';
    if (cleanPath.startsWith('/')) {
      return '$base$cleanPath';
    } else {
      return '$base/$cleanPath';
    }
  }

  bool _isImageFile(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.heic') ||
        lower.endsWith('.bmp');
  }

  void _showEnlargedImage(BuildContext context, {File? file, String? networkUrl}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss Preview",
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Main image container
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: InteractiveViewer(
                            panEnabled: true,
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: file != null
                                ? Image.file(
                                    file,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(
                                    networkUrl!,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey.shade900,
                                      width: double.infinity,
                                      height: 300,
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.broken_image_outlined, color: Colors.white60, size: 48),
                                          SizedBox(height: 12),
                                          Text(
                                            "Failed to load preview",
                                            style: TextStyle(color: Colors.white60, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // Title/Header (sleek, semi-transparent bar at top)
                    Positioned(
                      top: 16,
                      left: 24,
                      right: 24,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.controller.text.split('/').last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Premium Close Button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Zoom Hint at bottom
                    Positioned(
                      bottom: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in_rounded, color: Colors.white.withOpacity(0.8), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              "Pinch or double tap to zoom",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildImagePreview() {
    final text = widget.controller.text.trim();
    if (text.isEmpty || text == AppStr.filePickerDefaultText) {
      return const SizedBox.shrink();
    }

    // 1. If we have a local File picked in this session, show it instantly
    if (_localFile != null && _localFile!.path.split('/').last == text) {
      final isImg = _isImageFile(_localFile!.path);
      return GestureDetector(
        onTap: isImg ? () => _showEnlargedImage(context, file: _localFile) : null,
        child: _imageWrapper(Image.file(
          _localFile!,
          fit: BoxFit.cover,
        )),
      );
    }

    // 2. First, check if it's a local file path that exists on the device
    if (text.contains('/')) {
      final file = File(text);
      if (file.existsSync()) {
        final isImg = _isImageFile(file.path);
        return GestureDetector(
          onTap: isImg ? () => _showEnlargedImage(context, file: file) : null,
          child: _imageWrapper(Image.file(
            file,
            fit: BoxFit.cover,
          )),
        );
      }
    }

    // 3. Next, check if it's a local filename (no slashes) and load it from ApplicationDocumentsDirectory
    if (!text.contains('/')) {
      return FutureBuilder<File?>(
        future: loadFile(fileName: text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            final file = snapshot.data!;
            final isImg = _isImageFile(file.path);
            return GestureDetector(
              onTap: isImg ? () => _showEnlargedImage(context, file: file) : null,
              child: _imageWrapper(Image.file(
                file,
                fit: BoxFit.cover,
              )),
            );
          }

          // Fallback: try resolving as a network image
          final fullUrl = _resolveImageUrl(text);
          final isProbablyImage = _isImageFile(text);
          return GestureDetector(
            onTap: isProbablyImage ? () => _showEnlargedImage(context, networkUrl: fullUrl) : null,
            child: _imageWrapper(Image.network(
              fullUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
            )),
          );
        },
      );
    }

    // 4. Otherwise, it is a network path/URL (e.g. contains slashes but local file doesn't exist)
    final fullUrl = _resolveImageUrl(text);
    final isProbablyImage = _isImageFile(text);
    return GestureDetector(
      onTap: isProbablyImage ? () => _showEnlargedImage(context, networkUrl: fullUrl) : null,
      child: _imageWrapper(Image.network(
        fullUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
      )),
    );
  }

  Widget _imageWrapper(Widget imageChild) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: imageChild,
      ),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      color: Colors.grey.shade100,
      alignment: Alignment.center,
      child: const Icon(Icons.insert_drive_file, color: Colors.grey, size: 22),
    );
  }
}