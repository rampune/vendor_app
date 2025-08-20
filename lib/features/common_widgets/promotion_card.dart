import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../config/assets.dart';
import '../../config/config.dart';
import '../../config/theme.dart';
import 'book_button.dart';
class PromotionCard extends StatelessWidget {
  const PromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [
              const Color(0xFF101115),
              const Color(0xFF7FD8EF),
            ],
            begin: const FractionalOffset(1.0, 0.0),
            end: const FractionalOffset(0.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),


      ),
      child:
      Stack(children: [
        SizedBox(
            height: double.infinity,
            width: MediaQuery.of(context).size.width/2,
            child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.asset(AppAssetsPath.arjit,fit: BoxFit.fill,))),
        Positioned(
            right: 10,
            top: 10,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("LIVE\nMUSIC",
                  textAlign: TextAlign.right,
                  style: context.bodyLarge()?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: dynamicWhiteBtnTheme(context)
                  ),
                ),
                Text("PERFORMANCE",
                  textAlign: TextAlign.right,
                  style: context.bodyLarge()?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: dynamicWhiteBtnTheme(context)
                  ),
                ),
                5.height(),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white
                  ),
                  child: Text("BY ALEXANDER ARONWITZ"),
                ),
                10.height(),
                BookButton(

                )


              ],
            )),

      ],),
    );
  }
}
