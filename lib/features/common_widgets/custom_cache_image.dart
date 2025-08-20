import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({super.key,this.width,this.height,this.borderRadius,this.imgUrl});
  final double ?width,height,borderRadius;
  final String ?imgUrl;
  @override
  Widget build(BuildContext context) {
    return

      SizedBox(

        height: width??100,width: height??100,      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius??0),
        child: CachedNetworkImage(
          imageUrl:imgUrl?? "https://picsum.photos/id/237/200/300",
          placeholder: (context, url) => Center(child: CircularProgressIndicator(
            backgroundColor: dynamicThemeColor(context),

          )),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
      );

  }
}
