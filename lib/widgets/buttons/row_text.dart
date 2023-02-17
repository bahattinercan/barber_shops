import 'package:flutter/material.dart';

class RowTextButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function()? onTap;
  const RowTextButton({
    Key? key,
    required this.text,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Icon(iconData)
          ],
        ),
      ),
    );
  }
}
