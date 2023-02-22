import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextFormField extends StatefulWidget {
  final bool autofocus;
  final TextEditingController controller;
  final IconData? icon;
  final String? hintText, labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  BaseTextFormField({
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
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: TextStyle(
          color: ColorManager.disableColor,
        ),
        helperStyle: TextStyle(
          color: ColorManager.onSurface,
        ),
      ),
      validator: widget.validator,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
    );
  }
}
