import 'package:demaze/constants/color_constants.dart';
import 'package:demaze/local_storage/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

// Theme related cubit that will change the theme and save theme to the preferences
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required this.helper,
  }) : super(ThemeState(themeData: ThemeData.light()));

  final SharedPrefHelper helper;

  void changeTheme(AppTheme theme) {
    ThemeData newThemeData;

    switch (theme) {
      case AppTheme.dark:
        newThemeData = ThemeData.dark(
          useMaterial3: true,
        );
        break;
      case AppTheme.red:
        newThemeData = ThemeData(
          useMaterial3: true,
          primaryColor: Colors.red,
          appBarTheme: const AppBarTheme(color: Colors.red),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Change the button color here
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.red,
          ),
        );
        break;
      case AppTheme.green:
        newThemeData = ThemeData(
          useMaterial3: true,
          primaryColor: Colors.green,
          appBarTheme: const AppBarTheme(color: Colors.green),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Change the button color here
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green,
          ),
        );
        break;
      case AppTheme.yellow:
        newThemeData = ThemeData(
          useMaterial3: true,
          primaryColor: Colors.yellow,
          appBarTheme: const AppBarTheme(color: Colors.yellow),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Change the button color here
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.yellow,
          ),
        );
        break;
    }

    emit(ThemeState(themeData: newThemeData));
  }
}
