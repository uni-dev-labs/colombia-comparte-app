import 'package:flutter/material.dart';
import '../screens/screens.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const LoadingPage(),
  '/login': (context) => const LoginPage(),
  '/dashboard': (context) => const DashboardSuperAdminPage(),
  '/dashboard/pais': (context) => const DashboardAdminPaisPage(),
  '/portales': (context) => const AllPortalsPage(),
};