import 'package:flutter/material.dart';

const Tiny = 12.0;
const Small = 14.0;
const Medium = 16.0;
const Semi = 19.0;
const Large = 25.0;
const Bold =35.0;
const VeryBold = 45.0;
const String font = "Gilroy";

TextStyle smallText(Color colors) => TextStyle(
  color: colors,
  fontSize: Small,
  height: 1.5,
  fontFamily: font,
  fontWeight: FontWeight.w500,
);

TextStyle tiny(Color colors) => TextStyle(
  color: colors,
  fontSize: Tiny,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w600,
);

TextStyle small() => TextStyle(
  fontSize: Small,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

TextStyle smallBold(Color colors) => TextStyle(
  color: colors,
  fontSize: Small,
  height: 1.5,
  fontFamily: font,
  fontWeight: FontWeight.w600,
);

TextStyle mediumText(Color colors) => TextStyle(
  color: colors,
  fontSize: Medium,
  height: 1.5,
  fontFamily: font,
  fontWeight: FontWeight.w400,
);

TextStyle medium() => TextStyle(
  fontSize: Medium,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

TextStyle mediumSemiBold(Color colors) => TextStyle(
    fontSize: Semi,
    fontFamily: font,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: colors
);

TextStyle mediumBold(Color colors) => TextStyle(
  color: colors,
  fontSize: Medium,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w600,
);

TextStyle largeText(Color colors) => TextStyle(
  color: colors,
  fontSize: Large,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w600,
);

TextStyle large() => TextStyle(
  fontSize: Large,
  fontFamily: font,
  height: 1.5,
  fontWeight: FontWeight.w600,
);

TextStyle boldText(Color colors) => TextStyle(
  color: colors,
  fontSize: Bold,
  fontFamily: font,
  fontWeight: FontWeight.w600,
);

TextStyle bold() => TextStyle(
  fontSize: Bold,
  fontFamily: font,
  fontWeight: FontWeight.w700,
);

TextStyle veryBold() => TextStyle(
  fontSize: VeryBold,
  fontFamily: font,
  fontWeight: FontWeight.w700,
);
TextStyle veryBoldText(Color colors) => TextStyle(
    fontSize: VeryBold,
    fontFamily: font,
    fontWeight: FontWeight.w700,
    color: colors
);
