import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;
  static const int smallScreenThreshold = 800;
  static const int largeScreenThreshold = 1200;

  const ResponsiveWidget(
      {Key key,
      @required this.largeScreen,
      this.mediumScreen,
      this.smallScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallScreenThreshold;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > smallScreenThreshold;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > smallScreenThreshold &&
        MediaQuery.of(context).size.width < largeScreenThreshold;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > smallScreenThreshold) {
          return largeScreen;
        } else if (constraints.maxWidth < largeScreenThreshold &&
            constraints.maxWidth > smallScreenThreshold) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
