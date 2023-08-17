import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppTheme {
  static const Color primaryColor = Color(0xFFDA291C);
  static const Color secondColor = Color(0xFFF2A900);
  static const Color o3Blue = Color(0xFF002A4A);
  static const Color o3Orange = Color(0xFFFFA73E);
  static const Color o3Grey = Color(0xFFE4E7EC);
  static const Color o3Gray = Color(0xFF475464);
  static const Color success = Color(0xFF039855);
  static const Color o3Black = Color(0xFF000000);
  static  const Color o3Background =  Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD92D20);
  static const Color placeHolder = Color(0xFF98A2B3);
  static const Color tertiaryColor = Color(0xFF8B97A2);
  static const Color darkBackground = Color(0xFF26323F);
  static const Color lighterBackground = Color(0xFF415367);
  static const Color whiteBackground = Color(0xFFFFFFFF);
  static const Color disabledButtonColor = Color(0xFF434D57);
  static const Color disabledButtonTextColor = Color(0xFF1C2733);
  static const Color inputBackgroundColor = Color(0xFFC4C4C4);
  static const Color textLightGrey = Color(0xFF91A5BB);
  static const Color textDarkGrey = Color(0xFF909090);

  static TextStyle get title1 => const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 36,
  );

  static TextStyle get title2 => const TextStyle(
    color: Color(0xFF303030),
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  static TextStyle get title3 => const TextStyle(
    color: Color(0xFF303030),
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  // static TextStyle get subtitle1 => TextStyle(
  //   color: secondaryColor,
  //   fontWeight: FontWeight.w500,
  //   fontSize: 16,
  // );

  static TextStyle get subtitle2 => const TextStyle(
    color: Color(0xFF616161),
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  static TextStyle get bodyText1 => const TextStyle(
    color: tertiaryColor,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static TextStyle get bodyText2 => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static TextStyle get bodyText3 => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static TextStyle get subStyle =>
     const  TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color:Color(0xFF667085) );

  static TextStyle buttonWhiteTextStyle(
      {Color color = Colors.black,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.normal,
        double lineHeight = 1.35}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: lineHeight);
  }

  static Color darken(Color color, {double amount = .08}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    HSLColor hslDark =
    hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, {double amount = .08}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
    hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }


  static String money(double amount, {int digits = 2}) {
    var amt = NumberFormat.currency(
        symbol: '', locale: 'en-UK', decimalDigits: digits)
        .format(amount);
    return "\u20A6${amt}";
  }


  String maskNumber(String amt, {int digits = 0}) {
    double amount = double.parse(amt.toString());
    return NumberFormat.currency(
        symbol: '', locale: 'en-UK', decimalDigits: digits)
        .format(amount);
  }


  // currencyCode


  static double readMoney(String text, {int digits = 0}) {
    return NumberFormat.currency(
        symbol: '₦', locale: 'en-UK', decimalDigits: digits)
        .parse(text)
        .toDouble();
  }

  static String formatDate(DateTime date) {
    return DateFormat("dd-MM-yyy").format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat("hh:mm a").format(date);
  }

  // static Screen getScreen() {
  //   MediaQueryData win =
  //   MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  //   double size = win.size.width;
  //   Screen screen = Screen.phone;
  //   if (size <= 760){
  //     screen = Screen.phone;
  //   }
  //   else if (size > 760 && size < 1200)
  //     screen = Screen.tab;
  //   else if (size >= 1201) screen = Screen.win;
  //   return screen;
  // }
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {Color? color,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      TextStyle(
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );



}
