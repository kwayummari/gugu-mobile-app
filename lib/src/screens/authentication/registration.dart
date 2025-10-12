import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/provider/login-provider.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/utils/routes/route-names.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/gateway/registration-services.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_button.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool dont_show_password = true;
  bool obscure = true;
  bool obscure1 = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      isFlexible: false,
      showAppBar: true,
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppConst.black,
            size: screenWidth * 0.05,
          ),
        ),
        backgroundColor: AppConst.white,
        centerTitle: true,
        title: AppText(
          weight: FontWeight.w600,
          txt: 'Create Account',
          size: screenWidth * 0.045,
          color: AppConst.black,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  // Fullname input
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    textfieldcontroller: fullname,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Full Name',
                    obscure: false,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // Phone input
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    isPhone: true,
                    textfieldcontroller: phone,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Phone Number',
                    obscure: false,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // Password input
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppConst.grey,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    textfieldcontroller: password,
                    ispassword: true,
                    fillcolor: AppConst.white,
                    label: 'Password',
                    obscure: obscure,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // Confirm Password input
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure1 = !obscure1;
                        });
                      },
                      icon: Icon(
                        obscure1
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppConst.grey,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    textfieldcontroller: rpassword,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Confirm Password',
                    obscure: obscure1,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Sign up button
                  myProvider.myLoging == true
                      ? Center(
                        child: SpinKitCircle(
                          color: AppConst.primary,
                          size: screenWidth * 0.1,
                        ),
                      )
                      : SizedBox(
                        height: screenHeight * 0.065,
                        child: AppButton(
                          onPress: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            registrationService().registration(
                              context,
                              password.text,
                              rpassword.text,
                              fullname.text,
                              phone.text,
                            );
                          },
                          label: 'SIGN UP',
                          borderRadius: 8,
                          textColor: AppConst.white,
                          bcolor: AppConst.primary,
                        ),
                      ),
                  SizedBox(height: screenHeight * 0.035),
                  // Sign in link
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.login),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            txt: 'Already have an account? ',
                            size: screenWidth * 0.035,
                            color: AppConst.grey,
                            weight: FontWeight.w400,
                          ),
                          AppText(
                            txt: 'Sign In',
                            size: screenWidth * 0.035,
                            color: AppConst.primary,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  // Terms
                  Center(
                    child: AppText(
                      txt: 'By continuing you agree to Terms and Conditions',
                      size: screenWidth * 0.028,
                      color: AppConst.grey,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.035),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
