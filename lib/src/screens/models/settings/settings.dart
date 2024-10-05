import 'package:flutter/material.dart';
import 'package:gugu/src/screens/models/settings/account/account.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> phoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0743469680',
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      isFlexible: true,
      showAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppText(
          txt: 'Settings',
          size: 20,
          weight: FontWeight.bold,
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
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => account()));
            },
            leading: Icon(Icons.person),
            title: AppText(
              txt: 'Your Account',
              size: 15,
              weight: FontWeight.bold,
            ),
            subtitle: AppText(
                txt:
                    'See information about your account,download an archive of your data, or learn about your account deactivation options.',
                size: 14),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            onTap: () => phoneCall(),
            leading: Icon(Icons.phone),
            title: AppText(
              txt: 'Contact us',
              size: 15,
              weight: FontWeight.bold,
            ),
            subtitle: AppText(
                txt:
                    'Communicate through our office phone number incase of any emergency.(0762996305)',
                size: 14),
          ),
          SizedBox(
            height: 15,
          ),
          // ListTile(
          //   onTap: () => Navigator.of(context)
          //       .push(MaterialPageRoute(builder: (context) => TestNewApp())),
          //   leading: Icon(Icons.bluetooth),
          //   title: AppText(
          //     txt: 'Bluetooth Connection',
          //     size: 15,
          //     weight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
