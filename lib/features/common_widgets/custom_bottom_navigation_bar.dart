import 'package:flutter/material.dart';

import '../../config/theme.dart';
class CustomBottomNavigationBar extends StatefulWidget {
   CustomBottomNavigationBar({super.key,required this.callBack,this.currentIndex,this.listBottomItem});
  final Function(int) callBack;
  int ?currentIndex;
   final List<BottomNavigationBarItem> ?listBottomItem;
  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}
class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(


      selectedItemColor: AppColors.themeColor,
        unselectedItemColor: AppColors.lightGray,
        unselectedLabelStyle: TextStyle(color: AppColors.black),
        currentIndex: widget.currentIndex??0,
        onTap: (index){
          setState(() {
            selectedIndex=index;
            widget.currentIndex=index;
            widget.callBack(index);
          });
        },
        items: widget.listBottomItem??[

    ]);
  }
}

