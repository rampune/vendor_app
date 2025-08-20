import 'package:flutter/material.dart';

import 'overlay_loading_progress.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
        this.body,
        this.appBar,
        this.floatingActionButton,
        this.bottomNavigationBar,this.backgroundColor,this.drawer,
        this.scaffoldKey});

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Color?backgroundColor;
  final Widget? bottomNavigationBar,drawer;
  final GlobalKey<ScaffoldState> ?scaffoldKey;


  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        appBar: appBar,
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        body: PopScope(onPopInvokedWithResult: (bool didPop, Object? result) {
          OverlayLoadingProgress.stop();
        }, child: body??SizedBox()));
  }
}
