import 'package:flutter/material.dart';
import 'package:score_counter/data/storage.dart';
import 'package:score_counter/modal/game.dart';

const ColorScheme kLightTheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff000000),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffb3a7a6),
  onPrimaryContainer: Color(0xff0f0e0e),
  secondary: Color(0xffffffff),
  onSecondary: Color(0xff000000),
  secondaryContainer: Color(0xffdbd2cf),
  onSecondaryContainer: Color(0xff121211),
  tertiary: Color(0xffd4d4d4),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xffffffff),
  onTertiaryContainer: Color(0xff141414),
  error: Color(0xffb00020),
  onError: Color(0xffffffff),
  errorContainer: Color(0xfffcd8df),
  onErrorContainer: Color(0xff141213),
  background: Color(0xfff8f8f8),
  onBackground: Color(0xff090909),
  surface: Color(0xfff8f8f8),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xffe0e0e0),
  onSurfaceVariant: Color(0xff111111),
  outline: Color(0xff7c7c7c),
  outlineVariant: Color(0xffc8c8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff101010),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xff808080),
  surfaceTint: Color(0xff000000),
);

const ColorScheme kDarkTheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff9fc9ff),
  onPrimary: Color(0xff111415),
  primaryContainer: Color(0xff00325b),
  onPrimaryContainer: Color(0xffdee6ed),
  secondary: Color(0xffffb59d),
  onSecondary: Color(0xff151311),
  secondaryContainer: Color(0xff872100),
  onSecondaryContainer: Color(0xfff4e3de),
  tertiary: Color(0xff86d2e1),
  onTertiary: Color(0xff0f1515),
  tertiaryContainer: Color(0xff004e59),
  onTertiaryContainer: Color(0xffdeebec),
  error: Color(0xffcf6679),
  onError: Color(0xff150c0e),
  errorContainer: Color(0xffb1384e),
  onErrorContainer: Color(0xfffbe7eb),
  background: Color(0xff181a1d),
  onBackground: Color(0xffebecec),
  surface: Color(0xff181a1d),
  onSurface: Color(0xffebecec),
  surfaceVariant: Color(0xff3d4146),
  onSurfaceVariant: Color(0xffdfdfe0),
  outline: Color(0xff767c7c),
  outlineVariant: Color(0xff2b2d2d),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffafcff),
  onInverseSurface: Color(0xff141415),
  inversePrimary: Color(0xff536577),
  surfaceTint: Color(0xff9fc9ff),
);

late ObjectBox objectbox;

int ascend(Player p1, Player p2){
  if(p1.score>p2.score) {
    return 1;
  }
  return -1;
}

int desend(Player p1, Player p2){
  if(p1.score>p2.score) {
    return -1;
  }
  return 1;
}

