import 'package:demaze/bloc/app_theme/theme_cubit.dart';
import 'package:demaze/local_storage/shared_pref.dart';
import 'package:demaze/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'bloc/product/product_bloc.dart';

class SharedPreferencesDemo extends StatelessWidget {
  SharedPreferencesDemo({super.key});

  // Created instance of the shared preferences
  final _helper = SharedPrefHelper();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        // Initializing the blocs (Product and shared preferences)
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductBloc(helper: _helper),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => ThemeCubit(helper: _helper),
              lazy: false,
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Shared Preferences Demo',
                theme: state.themeData,
                home: const HomeScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
