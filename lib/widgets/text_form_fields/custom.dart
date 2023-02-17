import 'package:barbers/utils/validator_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool autofocus;
  final TextEditingController controller;
  final IconData icon;
  final String? hintText, labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;

  CustomTextFormField({
    Key? key,
    this.autofocus = false,
    required this.controller,
    this.icon = Icons.text_fields,
    this.hintText,
    this.labelText,
    this.validator = ValidatorManager.baseValidator,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(widget.icon),
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      validator: widget.validator,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
    );
  }
}
