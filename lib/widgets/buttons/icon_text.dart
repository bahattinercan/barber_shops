import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final Function func;
  final dynamic icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String text;
  final double? width, height;
  final BorderRadius? borderRadius;

  const IconTextButton({
    super.key,
    required this.func,
    required this.icon,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.margin,
    this.padding,
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colorer.secondary,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: iconColor ?? Colorer.onSecondary,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colorer.onSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
    );
  }
}
