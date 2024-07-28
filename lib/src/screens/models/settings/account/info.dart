import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/profile-service.dart';
import 'package:gugu/src/utils/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  var data;
  void fetchData() async {
    profileService ProfileService = profileService();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var id = sharedPreferences.getString('id');
    final datas = await ProfileService.profile(context, id!);
    setState(() {
      data = datas['user'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                text: 'Your account',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              ),
              TextSpan(
                text: data != null ? '\n@${data['name']}' : '',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => usernameChange()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 20, top: 20),
              child: Row(
                children: [
                  AppText(
                    txt: 'Full Name',
                    size: 15,
                    weight: FontWeight.bold,
                  ),
                  Spacer(),
                  AppText(
                    txt: data != null ? '@${data['name']}' : '',
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 10,
            ),
            child: Row(
              children: [
                AppText(
                  txt: 'Country',
                  size: 15,
                  weight: FontWeight.bold,
                ),
                Spacer(),
                AppText(
                  txt: 'Tanzania',
                  size: 15,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Uri.parse('https://aurorawavelabs.com'),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Designed and Maintained by ',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Aurorawave labs',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
