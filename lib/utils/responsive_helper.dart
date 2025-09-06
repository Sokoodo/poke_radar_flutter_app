import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).smallerThan(TABLET);
  }

  static bool isTablet(BuildContext context) {
    return ResponsiveBreakpoints.of(context).between(TABLET, DESKTOP);
  }

  static bool isDesktop(BuildContext context) {
    return ResponsiveBreakpoints.of(context).largerThan(TABLET);
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 4;
    return 6; // Desktop
  }

  static double getCardMaxWidth(BuildContext context) {
    if (isMobile(context)) return 180;
    if (isTablet(context)) return 200;
    return 220; // Desktop
  }

  static EdgeInsets getPaddingForScreen(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.all(8.0);
    if (isTablet(context)) return const EdgeInsets.all(16.0);
    return const EdgeInsets.all(24.0); // Desktop
  }

  static double getAppBarHeight(BuildContext context) {
    return kToolbarHeight;
  }

  static bool shouldShowSidebar(BuildContext context) {
    return isDesktop(context);
  }
}
