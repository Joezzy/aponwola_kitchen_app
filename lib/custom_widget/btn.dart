import 'package:aponwola/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:aponwola/common/SizeConfig.dart';
import 'package:aponwola/common/app_theme.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Color fontColor;
  final Color enabledColor;
  final Color? borderColor;
  final Color disabledColor;
  final Color disabledButtonTextColor;
  final FontWeight fontWeight;
  final double fontSize;
  final bool enabled;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isBordered;
  final double borderRadius;
  final double activityIndicatorSize;
  final TextAlign? textAlignment;
  TextOverflow? overflow;
  int? maxLines;
  double activityIndicatorLineWidth;
  IconData? icon;
  Widget? imageIcon;

  MyButton(
      {
        Key? key,
        this.width = double.maxFinite,
      this.height = 60,
      this.text = "Text",
      this.disabledButtonTextColor = AppTheme.o3Grey,
      this.fontColor = Colors.white,
      this.borderColor ,
      this.fontWeight = FontWeight.w500,
      this.enabledColor = AppTheme.primaryColor,
      this.disabledColor = AppTheme.o3Grey,
      this.fontSize = 16,
      this.enabled = true,
      this.isBordered = false,
      this.borderRadius = 20,
      this.activityIndicatorSize = 20,
      this.activityIndicatorLineWidth = 3,
      this.icon,
      this.maxLines = 1,
      this.textAlignment,
      this.overflow,
      this.imageIcon,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Screen screen = getScreen();
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MySize.size10),
        decoration: BoxDecoration(
          color: enabled ? enabledColor
              : disabledColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color:borderColor==null?enabledColor:borderColor!,width: 1 )
        ),
        height: height,
        width: (screen == Screen.tab) ? width / 1.4 : width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon!=null)
            Padding(
              padding:  EdgeInsets.only(right: 8.0),
              child: Icon(icon,size:20 ,),
            ),

            Center(
                child: imageIcon!=null?imageIcon!:Text(
              text,
              style: TextStyle(fontSize: fontSize, color: fontColor,fontWeight: fontWeight),
            )),
          ],
        ),
      ),
    );
  }
}
