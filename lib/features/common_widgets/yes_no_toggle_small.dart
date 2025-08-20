import 'package:flutter/material.dart';

class OnOffToggleSmall extends StatelessWidget {
  const OnOffToggleSmall({super.key,this.callBack,this.isOff=false});

  final GestureTapCallback? callBack;

  final bool isOff;

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 70,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
      ),
      child: InkWell(
        onTap: callBack,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment:
              isOff ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: Container(
                width: 40,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isOff ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child:  Center(
                    child: Text(
                      "OFF",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isOff ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "ON",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: !isOff ? Colors.white : Colors.black87,
                      ),
                    ),
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
