import 'package:demaze/bloc/app_theme/theme_cubit.dart';
import 'package:demaze/constants/color_constants.dart';
import 'package:demaze/general/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({Key? key}) : super(key: key);

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    // Initialize the theme cubit
    _themeCubit = BlocProvider.of<ThemeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Change Theme'),
      ),
      body: Column(
        children: [
          UiUtils.gap(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BuildColorContainer(
                color: Colors.black,
                onTap: () {
                  // Change theme
                  _themeCubit.changeTheme(AppTheme.dark);
                },
              ),
              BuildColorContainer(
                color: Colors.red,
                onTap: () {
                  // Change theme
                  _themeCubit.changeTheme(AppTheme.red);
                },
              ),
              BuildColorContainer(
                color: Colors.green,
                onTap: () {
                  // Change theme
                  _themeCubit.changeTheme(AppTheme.green);
                },
              ),
              BuildColorContainer(
                color: Colors.yellow,
                onTap: () {
                  // Change theme
                  _themeCubit.changeTheme(AppTheme.yellow);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Build square colored box that will show user,
// That user is going to the use this theme
class BuildColorContainer extends StatelessWidget {
  const BuildColorContainer({
    Key? key,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        width: 5.h,
        color: color,
      ),
    );
  }
}
