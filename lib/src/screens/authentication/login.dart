import 'package:gugu/src/provider/login-provider.dart';
import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:gugu/src/widgets/app_button.dart';
import 'package:gugu/src/widgets/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gugu/src/gateway/login-services.dart';
import 'package:gugu/src/widgets/app_base_screen.dart';
import 'package:gugu/src/widgets/app_text.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool marked = false;
  bool dont_show_password = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBaseScreen(
      isFlexible: false,
      showAppBar: false,
      bgcolor: AppConst.white,
      isvisible: false,
      backgroundImage: false,
      backgroundAuth: false,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  // Logo - responsive size
                  Center(
                    child: Image.asset(
                      'assets/icon.png',
                      height: screenHeight * 0.22,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Email or Phone input
                  AppInputText(
                    textsColor: AppConst.black,
                    textfieldcontroller: name,
                    ispassword: false,
                    fillcolor: AppConst.white,
                    label: 'Email or Phone',
                    obscure: false,
                    isemail: false,
                    isPhone: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // Password input - only show/hide icon
                  AppInputText(
                    textsColor: AppConst.black,
                    isemail: false,
                    textfieldcontroller: password,
                    ispassword: dont_show_password,
                    fillcolor: AppConst.white,
                    label: 'Password',
                    obscure: dont_show_password,
                    suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          dont_show_password = !dont_show_password;
                        });
                      },
                      icon: Icon(
                        dont_show_password
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppConst.grey,
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.045),
                  // Login button
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
                            loginService().login(
                              context,
                              name.text.toString(),
                              password.text.toString(),
                            );
                          },
                          label: 'LOGIN',
                          borderRadius: 8,
                          textColor: AppConst.white,
                          bcolor: AppConst.primary,
                        ),
                      ),
                  SizedBox(height: screenHeight * 0.06),
                  // Terms - subtle and small
                  Center(
                    child: AppText(
                      txt: 'By continuing you agree to Terms and Conditions',
                      size: screenWidth * 0.028,
                      color: AppConst.grey,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
