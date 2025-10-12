import 'package:flutter/material.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? fullname;
  String? email;
  String? phone;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      fullname = sharedPreferences.getString('name');
      email = sharedPreferences.getString('email');
      phone = sharedPreferences.getString('phone');
    });
  }

  Future<void> phoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '0762996305');
    await launchUrl(launchUri);
  }

  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      isFlexible: true,
      showAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.white,
        elevation: 0,
        title: AppText(
          txt: 'Settings',
          size: screenWidth * 0.045,
          weight: FontWeight.w600,
          color: AppConst.black,
        ),
        centerTitle: true,
      ),
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.025),

              // Account Information Section
              AppText(
                txt: 'Account Information',
                size: screenWidth * 0.035,
                color: AppConst.grey,
                weight: FontWeight.w500,
              ),
              SizedBox(height: screenHeight * 0.015),

              // Full Name
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConst.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      txt: 'Full Name',
                      size: screenWidth * 0.038,
                      color: AppConst.black,
                      weight: FontWeight.w600,
                    ),
                    Flexible(
                      child: Text(
                        fullname ?? 'Loading...',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: AppConst.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Email
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConst.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      txt: 'Email',
                      size: screenWidth * 0.038,
                      color: AppConst.black,
                      weight: FontWeight.w600,
                    ),
                    Flexible(
                      child: Text(
                        email?.isNotEmpty == true ? email! : 'N/A',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: AppConst.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Phone
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConst.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      txt: 'Phone',
                      size: screenWidth * 0.038,
                      color: AppConst.black,
                      weight: FontWeight.w600,
                    ),
                    Flexible(
                      child: Text(
                        phone?.isNotEmpty == true ? phone! : 'N/A',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: AppConst.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Actions Section
              AppText(
                txt: 'Actions',
                size: screenWidth * 0.035,
                color: AppConst.grey,
                weight: FontWeight.w500,
              ),
              SizedBox(height: screenHeight * 0.015),

              // Contact Us
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConst.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  onTap: () => phoneCall(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.005,
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: AppConst.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.phone_outlined,
                      color: AppConst.primary,
                      size: screenWidth * 0.05,
                    ),
                  ),
                  title: AppText(
                    txt: 'Contact Support',
                    size: screenWidth * 0.038,
                    weight: FontWeight.w600,
                    color: AppConst.black,
                  ),
                  subtitle: AppText(
                    txt: 'Get help and support',
                    size: screenWidth * 0.03,
                    color: AppConst.grey,
                  ),
                ),
              ),

              // Sign Out
              Container(
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  onTap: signOut,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.005,
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: screenWidth * 0.05,
                    ),
                  ),
                  title: AppText(
                    txt: 'Sign Out',
                    size: screenWidth * 0.038,
                    weight: FontWeight.w600,
                    color: Colors.red,
                  ),
                  subtitle: AppText(
                    txt: 'Sign out of your account',
                    size: screenWidth * 0.03,
                    color: AppConst.grey,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Footer
              Center(
                child: GestureDetector(
                  onTap:
                      () => launchUrl(Uri.parse('https://aurorawavelabs.com')),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Designed and Maintained by\n',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: AppConst.grey,
                          ),
                        ),
                        TextSpan(
                          text: 'Aurorawave Labs',
                          style: TextStyle(
                            color: AppConst.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.028,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
