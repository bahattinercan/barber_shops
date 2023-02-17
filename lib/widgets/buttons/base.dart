import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  BaseButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
