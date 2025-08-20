import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import '../../config/assets.dart';
class CustomProgressiveImage extends StatelessWidget {
  const CustomProgressiveImage({super.key,
    this.imgUrl,this.assetImgUrl,this.thumbnailImg,
    this.width,this.height,this.borderRadius
  });
  final String? thumbnailImg,imgUrl,assetImgUrl;
  final double? width,height;
  final BorderRadiusGeometry ?borderRadius;
  @override
  Widget build(BuildContext context) {
    return      ClipRRect(
      borderRadius: borderRadius??BorderRadius.circular(0),
      child: ProgressiveImage(
        fit: BoxFit.fill,
        placeholder: AssetImage(assetImgUrl??AppAssetsPath.loadingImage,),
        thumbnail: NetworkImage(thumbnailImg??imgUrl??""),
        image: NetworkImage(imgUrl??''),
        height:height?? 300,
        width:width?? 500,
      ),
    );
  }
}
