import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';

class OnOffToggle extends StatefulWidget {
  const OnOffToggle({super.key,required this.title,this.callBack});
  final String title;
  final Function(bool)? callBack;

  @override
  State<OnOffToggle> createState() => _OnOffToggleState();
}

class _OnOffToggleState extends State<OnOffToggle> {
  bool isYes = true;

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 130,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment:
            isYes ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: 65,
              height: 32,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isYes ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Row(
            children: [
              /*(
                      if(widget.callBack!=null){
      widget.callBack!(isYes);
    }
                   */
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(widget.callBack!=null){
                      widget.callBack!(true);
                    }
                    setState(() => isYes = true);

                  },
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: Text(
                      "close",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isYes ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(widget.callBack!=null){
                      widget.callBack!(false);
                    }
                    setState(() => isYes = false);},
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: Text(
                      "Open",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: !isYes ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
