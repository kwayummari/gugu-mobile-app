import 'package:gugu/src/screens/models/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:gugu/src/screens/models/orders/allOrders.dart';
import 'package:gugu/src/screens/models/dashboard/allStyles.dart';
import 'package:gugu/src/screens/models/dashboard/dashboard.dart';
import 'package:gugu/src/screens/models/payroll/payroll.dart';
import 'package:gugu/src/screens/models/profile/profile.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/screens/authentication/login.dart';
import 'package:gugu/src/screens/authentication/registration.dart';
import 'package:gugu/src/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.login: (context) => Login(),
  RouteNames.registration: (context) => Registration(),
  RouteNames.splash: (context) => Splash(),
  RouteNames.dashboard: (context) => Dashboard(),
  RouteNames.payroll: (context) => Payroll(),
  RouteNames.allStyles: (context) => AllStyles(),
  RouteNames.profile: (context) => Profile(),
  RouteNames.bottomNavigationBar: (context) => BottomNavigation(),
  RouteNames.getContentsById: (context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ContentsById(
      name: args?['name'],
      styleId: args?['styleId'],
      amount: args?['amount'],
    );
  },
};
