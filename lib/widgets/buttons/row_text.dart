import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class RowTextButton extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final Function()? onPressed;
  final Color? iconColor;

  const RowTextButton({
    Key? key,
    required this.text,
    this.iconData,
    this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  State<RowTextButton> createState() => _RowTextButtonState();
}

class _RowTextButtonState extends State<RowTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              color: Colorer.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            widget.iconData ?? Icons.arrow_forward_ios_rounded,
            color: widget.iconColor ?? Colorer.onSurface,
          ),
        ],
      ),
    );
  }
}
