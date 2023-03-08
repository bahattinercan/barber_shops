import 'package:barbers/utils/validator_manager.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final bool autofocus;
  final TextEditingController controller;
  final dynamic icon;
  final String hintText, labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const PasswordTextFormField({
    Key? key,
    this.autofocus = false,
    required this.controller,
    required this.icon,
    this.hintText = "******",
    required this.labelText,
    this.validator = ValidatorManager.baseValidator,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isHidden,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffix: InkWell(
          onTap: _togglePasswordView,
          child: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
