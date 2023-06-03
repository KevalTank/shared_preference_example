import 'package:flutter/material.dart';

// Unfocused wrapper which is used to un-focus the
class UnFocusWrapper extends StatelessWidget {
  const UnFocusWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
