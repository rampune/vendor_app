library modal_progress_hud_nsn;
import "dart:ui";
import "package:flutter/material.dart";
import "package:new_pubup_partner/config/extensions.dart";

class CustomLoader extends StatelessWidget {
  /// A required [bool]to toggle the loading animation.
  final bool inAsyncCall;

  /// A [double] value which states how opaque the loading overlay should be, defaults to 0.3
  final double opacity;

  /// A [Color] object which is assigned to the loading barrier, defaults to grey
  final Color color;

  /// An [Offset] object which is applied to the [progressIndicator] when specified.
  final Offset? offset;

  /// A [bool] value which sets the `loading screen can be dismissible by tapping on the loading screen` rule.
  final bool dismissible;

  /// A [Widget] which should be the the widget to be shown behind the loading barrier.
  final Widget child;

  /// A [double] value specifying the amount of background blur when progress hud is active.
  final double blur;

  const CustomLoader({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.black,
    /* this.progressIndicator = const CircularProgressIndicator(
      color: AppColors.themeColor,
    ),*/
    this.offset,
    this.dismissible = false,
    required this.child,
    this.blur = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 24),
        child: Center(
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 1, color: Theme.of(context).primaryColor))),
        ),
      );
    } else {
      layOutProgressIndicator = Positioned(
        left: offset!.dx,
        top: offset!.dy,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 24),
          child: Center(
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  //
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Theme.of(context).primaryColor))),
          ),
        ),
      );
    }

    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: dismissible, color: color),
          ),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}

Widget getLoader(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor, strokeWidth: 1),
  ).sizedBox(height: 100);
}
