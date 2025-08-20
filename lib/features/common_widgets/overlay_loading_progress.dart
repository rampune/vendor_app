import 'package:flutter/material.dart';

class OverlayLoadingProgress {
  OverlayLoadingProgress._() {}
  static OverlayEntry? _overlay;

  static start(
    BuildContext context, {
    Color? barrierColor = Colors.black54,
    Widget? widget,
    bool? fullScreen,
    String? gifOrImagePath,
    bool barrierDismissible = false,
    double? loadingWidth,
  }) async {
    if (_overlay != null) return;
    _overlay = OverlayEntry(builder: (BuildContext context) {
      return _LoadingWidget(
        barrierColor: barrierColor ?? Colors.black54,
        widget: widget,
        fullScreen: fullScreen ?? false,
        gifOrImagePath: gifOrImagePath,
        barrierDismissible: barrierDismissible,
        loadingWidth: loadingWidth,
      );
    });
    if (_overlay != null) {
      Future.delayed(Duration.zero, () {
        Overlay.of(context).insert(_overlay!);
      });
    }
  }

  static stop() {
    _overlay?.remove();
    _overlay = null;
  }
}

class _LoadingWidget extends StatelessWidget {
  final Widget? widget;

  // final Color? color;
  final Color? barrierColor;
  final String? gifOrImagePath;
  final bool barrierDismissible;
  final bool fullScreen;
  final double? loadingWidth;

  const _LoadingWidget({
    Key? key,
    this.widget,
    // this.color,
    this.barrierColor,
    this.gifOrImagePath,
    required this.barrierDismissible,
    required this.fullScreen,
    this.loadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barrierDismissible ? OverlayLoadingProgress.stop : null,
      child: Container(
        margin: EdgeInsets.only(
            top: fullScreen
                ? 0
                : kToolbarHeight + MediaQuery.viewPaddingOf(context).top),
        // constraints: const BoxConstraints.expand(),
        color: barrierColor,
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
      ),
    );
  }
}
