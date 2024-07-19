import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// CustomRefreshIndicator is a widget that wraps its child with a pull-to-refresh functionality.
/// It uses the SmartRefresher widget from the pull_to_refresh package.
class CustomRefreshIndicator extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The controller for managing the state of the refresh indicator.
  final RefreshController refreshController;

  /// Callback function to be executed when a refresh is triggered.
  final VoidCallback onRefresh;

  /// Creates a CustomRefreshIndicator.
  ///
  /// The [child], [refreshController], and [onRefresh] parameters are required.
  CustomRefreshIndicator({
    required this.child,
    required this.refreshController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      header: CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          Widget body;
          // Determines the widget to display based on the refresh status
          if (mode == RefreshStatus.idle) {
            body = Text("Pull down to refresh");
          } else if (mode == RefreshStatus.refreshing) {
            body = CircularProgressIndicator();
          } else if (mode == RefreshStatus.completed) {
            body = Text("Refresh completed!");
          } else {
            body = Text("Release to refresh");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: child,
    );
  }
}
