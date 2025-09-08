import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'routes.dart';
import '../utils/constants.dart';

class PokeTrendRadarApp extends StatelessWidget {
  const PokeTrendRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PokeTrendRadar',
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstants.homeRoute,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(body: Center(child: Text('Page not found'))),
      ),
    );
  }
}
