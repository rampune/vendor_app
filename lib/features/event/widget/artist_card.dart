
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_cache_image.dart';
import 'package:new_pubup_partner/features/event/widget/ticket_button.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
class ArtistCard extends StatelessWidget {
  final String name;
  final String industry;
  final String imageName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ArtistCard({
    super.key,
    required this.name,
    required this.industry,
    required this.imageName,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width / 3;

    return ClipPath(
      clipper: PremiumTicketClipper(),
      child: Container(
        width: cardWidth,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [AppColors.themeColor, AppColors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.darkGray, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Top right buttons
            Positioned(
              bottom: 0,
              right: 0,
              child:      IconButton(
                icon: const Icon(Icons.delete, size: 16, color: Colors.redAccent),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),

            // Main content
            Row(
              children: [
                imageName.contains("/artists/")?SizedBox(
                  height: 40,
                  width: 40,
                  child: CustomCacheImage(
                    borderRadius: 40,
                    imgUrl: "https://adminapi.perseverancetechnologies.com$imageName",),

                ):     FutureBuilder(future: loadFile(fileName: imageName),
                    builder: (BuildContext context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.data!=null){
                      return SizedBox(
                          height: 40,width: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(snapshot.data!,fit: BoxFit.fill,)));
                    }else{
                      return Icon(Icons.image_not_supported_outlined);
                    }
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                    }),

                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        industry,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
