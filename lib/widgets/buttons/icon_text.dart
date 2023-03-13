import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final void Function()? func;
  final IconData icon;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String text;
  final double? textSize;
  final double? width, height;
  final BorderRadius? borderRadius;

  const IconTextButton({
    super.key,
    required this.func,
    required this.icon,
    this.margin,
    this.padding,
    required this.text,
    this.textSize,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: ElevatedButton(
        onPressed: func,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: Colorer.onSecondary,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: Colorer.onSecondary,
              fontWeight: FontWeight.w700,
              fontSize: textSize ?? 16,
            ),
          ),
        ]),
      ),
    );
    // return GestureDetector(
    //   onTap: () => func(),
    //   child: Container(
    //     width: width,
    //     height: height,
    //     margin: margin,
    //     padding: padding,
    //     decoration: BoxDecoration(
    //       color: backgroundColor ?? Colorer.secondary,
    //       borderRadius: borderRadius ?? BorderRadius.circular(16),
    //     ),
    //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //       Icon(
    //         icon,
    //         color: iconColor ?? Colorer.onSecondary,
    //       ),
    //       const SizedBox(width: 5),
    //       Text(
    //         text,
    //         style: TextStyle(
    //           color: textColor ?? Colorer.onSecondary,
    //           fontWeight: FontWeight.w700,
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
