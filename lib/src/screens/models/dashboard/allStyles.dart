import 'package:gugu/src/screens/models/available_courses/available_courses.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class allStyles extends StatefulWidget {
  const allStyles({Key? key}) : super(key: key);

  @override
  State<allStyles> createState() => _allStylesState();
}

class _allStylesState extends State<allStyles> {
  var fullname;
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

  TextEditingController search = TextEditingController();

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
          title: AppText(txt: 'All Hair Styles', size: 20, color: AppConst.white, weight: FontWeight.bold,),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            availableCourses(),
          ],
        ));
  }
}
