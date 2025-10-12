import 'package:gugu/src/screens/models/available_hairStyle/available_hairStyle.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController search = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      isFlexible: true,
      showAppBar: true,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: AppInputText(
              textsColor: AppConst.black,
              textfieldcontroller: search,
              ispassword: false,
              fillcolor: AppConst.white,
              label: 'Search',
              obscure: false,
              suffixicon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppConst.grey.withOpacity(0.5),
                  size: screenWidth * 0.05,
                ),
              ),
              onChange: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              isemail: false,
              isPhone: false,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          // Section header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              children: [
                AppText(
                  txt: 'Services',
                  size: screenWidth * 0.038,
                  color: AppConst.black,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          AvailableHairStyles(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
