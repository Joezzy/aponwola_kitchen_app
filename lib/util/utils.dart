

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum Screen { phone, tab, win }

Screen getScreen() {
  MediaQueryData win =
  MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  double size = win.size.width;
  Screen screen = Screen.phone;
  if (size <= 760)
    {
      screen = Screen.phone;
    }
  else if (size > 760 && size < 1200){
    screen = Screen.tab;
  }
  else if (size >= 1201)
    {
      screen = Screen.win;
    }

  return screen;
}






