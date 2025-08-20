import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';

class YesNoToggle extends StatefulWidget {
  const YesNoToggle({super.key,required this.title,this.callBack,this.isYes=false});
  final String title;
  final Function(bool)? callBack;
final bool isYes;
  @override
  State<YesNoToggle> createState() => _YesNoToggleState();
}

class _YesNoToggleState extends State<YesNoToggle> {
  bool isYes = false;
@override
  void initState() {
   isYes=widget.isYes;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          widget.title,
          style: context.titleSmall(),
        ),
        const SizedBox(height: 12),
        Container(
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
                    color: isYes ? Colors.green : Colors.red,
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
                          "Yes",
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
                          "No",
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
        ),
      ],
    );
  }
}
