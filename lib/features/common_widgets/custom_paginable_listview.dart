import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

bool isAlmostAtTheEndOfTheScroll(
        ScrollUpdateNotification scrollUpdateNotification) =>
    scrollUpdateNotification.metrics.pixels >=
    scrollUpdateNotification.metrics.maxScrollExtent * 0.8;

bool isScrollingDownwards(ScrollUpdateNotification scrollUpdateNotification) =>
    scrollUpdateNotification.scrollDelta! > 0.0;

enum LastItem { progressIndicator, errorIndicator, emptyContainer }

const Key keyForEmptyContainerWidgetOfPaginableListView =
    Key('EMPTY_CONTAINER_OF_PAGINABLELISTVIEW');

const Key keyForEmptyContainerWidgetOfPaginableSliverChildBuilderDelegate =
    Key('EMPTY_CONTAINER_OF_PAGINABLESLIVERCHILDBUILDERDELEGATE');

class CustomPaginableListView extends StatefulWidget {
  final bool _isListViewSeparated;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  final IndexedWidgetBuilder? separatorBuilder;

  final double? itemExtent;
  final Widget? prototypeItem;
  final int? semanticChildCount;

  final Future<void> Function() loadMore;

  final Widget progressIndicatorWidget;

  final Widget Function(Exception exception, void Function() tryAgain)
      errorIndicatorWidget;

  // ignore: unused_element
  const CustomPaginableListView._(
      this._isListViewSeparated,
      this.scrollDirection,
      this.reverse,
      this.controller,
      this.primary,
      this.physics,
      this.shrinkWrap,
      this.padding,
      this.itemBuilder,
      this.itemCount,
      this.addAutomaticKeepAlives,
      this.addRepaintBoundaries,
      this.addSemanticIndexes,
      this.cacheExtent,
      this.dragStartBehavior,
      this.keyboardDismissBehavior,
      this.restorationId,
      this.clipBehavior,
      this.separatorBuilder,
      this.itemExtent,
      this.prototypeItem,
      this.semanticChildCount,
      this.loadMore,
      this.progressIndicatorWidget,
      this.errorIndicatorWidget);

  const CustomPaginableListView.builder({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    required this.loadMore,
    required this.progressIndicatorWidget,
    required this.errorIndicatorWidget,
    required this.itemBuilder,
    required this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : _isListViewSeparated = false,
        separatorBuilder = null,
        super(key: key);

  const CustomPaginableListView.separated({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required this.loadMore,
    required this.progressIndicatorWidget,
    required this.errorIndicatorWidget,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : _isListViewSeparated = true,
        itemExtent = null,
        prototypeItem = null,
        semanticChildCount = null,
        super(key: key);

  @override
  _CustomPaginableListViewState createState() =>
      _CustomPaginableListViewState();
}

class _CustomPaginableListViewState extends State<CustomPaginableListView> {
  late ValueNotifier<LastItem> valueNotifier;

  late bool isValueNotifierDisposed;

  late bool isLoadMoreBeingCalled;

  late Exception exception;

  void tryAgain() => performPagination();

  Future<void> performPagination() async {
    valueNotifier.value = LastItem.progressIndicator;
    isLoadMoreBeingCalled = true;
    try {
      await widget.loadMore();
      isLoadMoreBeingCalled = false;
      if (!isValueNotifierDisposed) {
        valueNotifier.value = LastItem.emptyContainer;
      }
    } on Exception catch (exception) {
      this.exception = exception;
      if (!isValueNotifierDisposed) {
        valueNotifier.value = LastItem.errorIndicator;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(LastItem.emptyContainer);
    isValueNotifierDisposed = false;
    isLoadMoreBeingCalled = false;
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    isValueNotifierDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification scrollUpdateNotification) {
        if (isAlmostAtTheEndOfTheScroll(scrollUpdateNotification) &&
            isScrollingDownwards(scrollUpdateNotification)) {
          if (!isLoadMoreBeingCalled) {
            performPagination();
          }
        }
        return false;
      },
      child: widget._isListViewSeparated
          ? ListView.separated(
              scrollDirection: widget.scrollDirection,
              reverse: widget.reverse,
              controller: widget.controller,
              primary: widget.primary,
              physics: widget.physics,
              shrinkWrap: widget.shrinkWrap,
              padding: widget.padding,
              itemBuilder: (context, index) {
                if (index == widget.itemCount) {
                  return ValueListenableBuilder<LastItem>(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      if (value == LastItem.emptyContainer) {
                        return widget.progressIndicatorWidget;
                      } else if (value == LastItem.errorIndicator) {
                        return widget.errorIndicatorWidget(exception, tryAgain);
                      }
                      return widget.progressIndicatorWidget;
                    },
                  );
                }
                return widget.itemBuilder(context, index);
              },
              separatorBuilder: (context, index) {
                if (index == widget.itemCount - 1) {
                  return Container();
                }
                return widget.separatorBuilder!(context, index);
              },
              itemCount: widget.itemCount + 1,
              addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
              addRepaintBoundaries: widget.addRepaintBoundaries,
              addSemanticIndexes: widget.addSemanticIndexes,
              cacheExtent: widget.cacheExtent,
              dragStartBehavior: widget.dragStartBehavior,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              restorationId: widget.restorationId,
              clipBehavior: widget.clipBehavior,
            )
          : ListView.builder(
              scrollDirection: widget.scrollDirection,
              reverse: widget.reverse,
              controller: widget.controller,
              primary: widget.primary,
              physics: widget.physics,
              shrinkWrap: widget.shrinkWrap,
              padding: widget.padding,
              itemExtent: widget.itemExtent,
              prototypeItem: widget.prototypeItem,
              itemBuilder: (context, index) {
                if (index == widget.itemCount) {
                  return ValueListenableBuilder<LastItem>(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      if (value == LastItem.emptyContainer) {
                        return Container(
                          key: keyForEmptyContainerWidgetOfPaginableListView,
                        );
                      } else if (value == LastItem.errorIndicator) {
                        return widget.errorIndicatorWidget(exception, tryAgain);
                      }
                      return widget.progressIndicatorWidget;
                    },
                  );
                }
                return widget.itemBuilder(context, index);
              },
              itemCount: widget.itemCount + 1,
              addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
              addRepaintBoundaries: widget.addRepaintBoundaries,
              addSemanticIndexes: widget.addSemanticIndexes,
              cacheExtent: widget.cacheExtent,
              semanticChildCount: widget.semanticChildCount,
              dragStartBehavior: widget.dragStartBehavior,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              restorationId: widget.restorationId,
              clipBehavior: widget.clipBehavior,
            ),
    );
  }
}
