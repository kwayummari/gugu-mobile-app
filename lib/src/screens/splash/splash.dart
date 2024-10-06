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
    return Scaffold(
      backgroundColor: AppConst.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitPouringHourGlass(
              duration: const Duration(seconds: 3),
              size: 100,
              color: AppConst.white,
            ),
            AppText(
              txt: 'Powered by Aurorawave labs @${DateTime.now().year}',
              size: 15,
              color: AppConst.white,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
