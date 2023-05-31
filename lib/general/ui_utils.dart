import 'package:flutter/material.dart';

class UiUtils {
  UiUtils._();

  static Widget gap({double height = 20, double? width = 20}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
