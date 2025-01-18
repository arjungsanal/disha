import 'package:flutter/material.dart';

const String _FONT_FAMILY = 'SpaceGrotesk';
const String _TITLE_FAMILY ='Gluten';

class CustomStyle {
  static TextStyle TitleText = TextStyle(fontFamily: _TITLE_FAMILY, fontWeight: FontWeight.w600);

   static TextStyle Bold =
      TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w700);

  static TextStyle SemiBold =
      TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w600);

  static TextStyle Medium =
      TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w500);

static TextStyle Regular =
      TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w400);

static TextStyle Light =
      TextStyle(fontFamily: _FONT_FAMILY, fontWeight: FontWeight.w200);


}
