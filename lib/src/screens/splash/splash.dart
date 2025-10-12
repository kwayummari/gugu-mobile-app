// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:gugu/src/functions/splash.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/widgets/app_text.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SplashFunction().navigatorToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppConst.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo - larger and responsive
            Image.asset('assets/icon.png', height: screenHeight * 0.25),
            SizedBox(height: screenHeight * 0.04),
            // Loading indicator
            SpinKitCircle(size: screenWidth * 0.1, color: AppConst.primary),
            SizedBox(height: screenHeight * 0.1),
            // Footer
            AppText(
              txt: 'Powered by Aurorawave Labs',
              size: screenWidth * 0.028,
              color: AppConst.grey,
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
