import 'package:gugu/src/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color bcolor;
  final double borderRadius;
  final Color textColor;
  final Color? borderColor;

  const AppButton({
    Key? key,
    required this.onPress,
    required this.label,
    required this.borderRadius,
    required this.textColor,
    required this.bcolor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: borderColor ?? bcolor, width: 2),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      onPressed: () => onPress(),
      child: AppText(
        txt: label,
        color: borderColor ?? bcolor,
        size: 20,
        weight: FontWeight.bold,
      ),
    );
  }
}
