import 'package:gugu/src/screens/models/available_hairStyle/available_hairStyle.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          toolbarHeight: 100,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: AppConst.white,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: AppConst.primary,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    AppText(
                      txt: 'Welcome \n${fullname}',
                      size: 18,
                      weight: FontWeight.w600,
                      color: AppConst.white,
                    ),
                    Spacer(),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  AppText(
                    txt: 'Available Hair Styles',
                    size: 15,
                    color: AppConst.black,
                    weight: FontWeight.w700,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.allStyles,
                    ),
                    child: AppText(
                      txt: 'View All',
                      size: 15,
                      color: AppConst.black,
                      weight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppConst.black,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
            availableHairStyles(searchQuery: searchQuery),
          ],
        ));
  }
}
