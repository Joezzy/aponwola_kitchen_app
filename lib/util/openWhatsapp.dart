

import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

openWhatsapp(String msg){
  var whatsappUrl = "whatsapp://send?phone=2349083669369&text=$msg";
  try {
    launchUrl(Uri.parse(whatsappUrl));
  } catch (e) {
    log(e.toString());
  }
}