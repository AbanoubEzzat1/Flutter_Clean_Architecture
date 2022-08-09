// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

//regular_Style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWightManager.regular,
    color,
  );
}

//medium_Style
TextStyle getMediumStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWightManager.medium,
    color,
  );
}

//light_Style
TextStyle getLightStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWightManager.light,
    color,
  );
}

//bold_Style
TextStyle getBoldStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWightManager.bold,
    color,
  );
}

//semibold_Style
TextStyle getSemiboldStyle({
  double fontSize = FontSize.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWightManager.semibold,
    color,
  );
}
