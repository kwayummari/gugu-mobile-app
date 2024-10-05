import 'package:gugu/src/screens/models/available_hairStyle/available_hairStyle.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllStyles extends StatefulWidget {
  const AllStyles({Key? key}) : super(key: key);

  @override
  State<AllStyles> createState() => _AllStylesState();
}

class _AllStylesState extends State<AllStyles> {
  var fullname;
  TextEditingController search = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    getName();
    super.initState();
  }

  Future<String> getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    setState(() {
      fullname = name.toString();
    });
    return name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppConst.primary,
        title: AppText(
          txt: 'All Hair Styles',
          size: 20,
          color: AppConst.white,
          weight: FontWeight.bold,
        ),
      ),
      isFlexible: true,
      showAppBar: true,
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppInputText(
                textsColor: AppConst.black,
                textfieldcontroller: search,
                ispassword: false,
                fillcolor: AppConst.white,
                label: 'Search by name',
                obscure: false,
                icon: null,
                suffixicon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                onChange: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                isemail: false,
                isPhone: false,
              )),
          SizedBox(height: 20),
          AvailableHairStyles(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
