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
  final Screen = [
    Dashboard(),
    Expenses(),
    Payroll(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConst.black,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: Screen[index],
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: AppConst.black,
                primaryColor: AppConst.black,
              ),
              child: BottomNavigationBar(
                selectedItemColor: AppConst.primary,
                unselectedItemColor: AppConst.grey,
                backgroundColor: AppConst.black,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_box), label: 'Add Expenses'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.payment), label: 'Payroll'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings_suggest_outlined),
                      label: 'My Account'),
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
