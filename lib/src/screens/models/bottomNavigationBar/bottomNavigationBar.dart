// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages, library_private_types_in_public_api, import_of_legacy_library_into_null_safe
import 'package:gugu/src/screens/models/dashboard/dashboard.dart';
import 'package:gugu/src/screens/models/expenses/expenses.dart';
import 'package:gugu/src/screens/models/payroll/payroll.dart';
import 'package:gugu/src/screens/models/settings/settings.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  final Screen = [Dashboard(), Expenses(), Payroll(), Settings()];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppConst.white,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: Screen[index],
            extendBody: false,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppConst.white,
                boxShadow: [
                  BoxShadow(
                    color: AppConst.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                elevation: 0,
                selectedItemColor: AppConst.primary,
                unselectedItemColor: AppConst.grey.withOpacity(0.6),
                backgroundColor: AppConst.white,
                selectedFontSize: screenWidth * 0.03,
                unselectedFontSize: screenWidth * 0.028,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: screenWidth * 0.06),
                    activeIcon: Icon(Icons.home, size: screenWidth * 0.06),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.receipt_long_outlined,
                      size: screenWidth * 0.06,
                    ),
                    activeIcon: Icon(
                      Icons.receipt_long,
                      size: screenWidth * 0.06,
                    ),
                    label: 'Expenses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.payments_outlined,
                      size: screenWidth * 0.06,
                    ),
                    activeIcon: Icon(Icons.payments, size: screenWidth * 0.06),
                    label: 'Payroll',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings_outlined,
                      size: screenWidth * 0.06,
                    ),
                    activeIcon: Icon(Icons.settings, size: screenWidth * 0.06),
                    label: 'Settings',
                  ),
                ],
                currentIndex: index,
                onTap: (index) {
                  if (mounted) setState(() => this.index = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
