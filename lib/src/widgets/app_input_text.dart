import 'package:gugu/src/utils/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:gugu/src/widgets/app_text.dart';

class AppInputText extends StatelessWidget {
  final TextEditingController? textfieldcontroller;
  final String? label;
  final Icon? icon;
  final Color? fillcolor;
  final Color? textsColor;
  final IconButton? suffixicon;
  final bool obscure;
  final Function? validate;
  final Function(String)? onChange;
  final bool ispassword;
  final bool isemail;
  final bool? enabled;
  final bool? isPhone;
  final double? circle;
  final labelWeight;
  final TextInputType? keyboardType;
  AppInputText(
      {Key? key,
      this.isPhone,
      required this.textfieldcontroller,
      required this.ispassword,
      required this.isemail,
      required this.fillcolor,
      this.textsColor,
      this.icon,
      this.suffixicon,
      this.onChange,
      required this.label,
      required this.obscure,
      this.validate,
      this.enabled,
      this.circle,
      this.keyboardType,
      this.labelWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 0, right: 0),
      child: TextFormField(
        enabled: enabled ?? true,
        style: TextStyle(
          color: textsColor ?? AppConst.white,
          fontSize: 15,
        ),
        onChanged: onChange,
        obscureText: obscure,
        obscuringCharacter: '•',
        controller: textfieldcontroller,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: AppConst.grey.withOpacity(0.3), width: 1),
          ),
          label: AppText(
            txt: label,
            size: 14,
            weight: labelWeight ?? FontWeight.w400,
            color: AppConst.grey,
          ),
          filled: true,
          fillColor: fillcolor,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: AppConst.grey.withOpacity(0.2), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: AppConst.grey.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: AppConst.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: Colors.red.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(circle ?? 8.0),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
          prefixIcon: icon,
          suffixIcon: suffixicon,
        ),
        validator: (value) {
          String pattern = r'([0][6,7]\d{8})';
          RegExp passwordRegex = new RegExp(pattern);
          RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
          if (ispassword == true && isemail == false && isPhone == false) {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            }
            if (!regex.hasMatch(value)) {
              return 'Password should contain \n -at least one upper case \n -at least one lower case \n -at least one digit \n -at least one Special character \n -Must be at least 8 characters in length';
            }
            return null;
          } else if (isemail == true &&
              ispassword == false &&
              isPhone == false) {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            }
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          } else if (isPhone == true &&
              isemail == false &&
              ispassword == false) {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            }
            if (!passwordRegex.hasMatch(value)) {
              return 'Please enter a valid phone number';
            }
            return null;
          } else {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            }
            return null;
          }
        },
      ),
    );
  }
}
