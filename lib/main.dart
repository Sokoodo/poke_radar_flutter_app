import 'package:flutter/material.dart';
import 'package:poke_radar_app/app.dart';
import 'package:poke_radar_app/routes.dart';

void main() {
  // Initialize dependencies
  AppRoutes.initDependencies();

  runApp(const PokeTrendRadarApp());
}
