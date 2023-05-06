import 'package:flutter/material.dart';
import 'package:stream/utils/colors.dart';

class Themes {
  final BuildContext context;
  Themes(this.context);

  ThemeData get lightMode => ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
          selectedItemColor: buttonColor,
          unselectedItemColor: primaryColor,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: appBar,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
      );

  ThemeData get darkMode => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColorDark,
        bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
          selectedItemColor: bottomNav,
          unselectedItemColor: primaryColorDark,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: appBar,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColorDark,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: primaryColorDark,
        ),
      );
}
