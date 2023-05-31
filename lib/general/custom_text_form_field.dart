import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.fieldTitle,
    this.isProductDescriptionField = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String fieldTitle;
  final bool isProductDescriptionField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: fieldTitle,
        border: const OutlineInputBorder(),
      ),
      maxLines: isProductDescriptionField ? 5 : 1,
    );
  }
}
