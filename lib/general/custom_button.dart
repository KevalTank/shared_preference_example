import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.height,
    this.width,
    this.inProgress = false,
  }) : super(key: key);

  final void Function()? onPressed;
  final String buttonText;
  final double? height;
  final double? width;
  final bool? inProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 6.h,
      width: width ?? 100.w,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}
