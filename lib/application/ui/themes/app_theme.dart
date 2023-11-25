import 'package:flutter/material.dart';
import 'package:flutter_fest/application/ui/themes/app_colors.dart';

const maxScreenWidth = 500.0;

abstract class AppTheme {
  static final light = ThemeData(
      dialogTheme: const DialogTheme(
        backgroundColor: Color.fromARGB(255, 48, 47, 47),
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.darkText,
      ));
}
