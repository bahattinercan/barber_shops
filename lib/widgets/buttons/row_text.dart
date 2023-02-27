import 'package:barbers/utils/color_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RowTextButton extends StatefulWidget {
  final String text;
  final IconData iconData;
  final Function()? onPressed;
  Color? iconColor;

  RowTextButton({
    Key? key,
    required this.text,
    required this.iconData,
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
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            widget.iconData,
            color: widget.iconColor == null ? ColorManager.onSurface : widget.iconColor,
          ),
        ],
      ),
    );
  }
}
