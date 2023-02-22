import 'package:barbers/utils/color_manager.dart';
import 'package:flutter/material.dart';

class RowTextButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function()? onPressed;
  const RowTextButton({
    Key? key,
    required this.text,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            iconData,
            color: ColorManager.onSurface,
          ),
        ],
      ),
    );
  }
}
