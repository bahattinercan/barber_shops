import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class EditTextButton extends StatefulWidget {
  final String text;
  final String label;
  final void Function()? onTap;
  const EditTextButton({
    Key? key,
    required this.label,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  State<EditTextButton> createState() => _EditTextButtonState();
}

class _EditTextButtonState extends State<EditTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colorer.onBackground,
                ),
              ),
              const SizedBox(width: 2.5),
              GestureDetector(
                onTap: widget.onTap,
                child: const Icon(
                  Icons.edit,
                  color: Colorer.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.5),
          Text(widget.text,
              style: const TextStyle(
                fontSize: 16,
                color: Colorer.onPrimary,
              )),
        ],
      ),
    );
  }
}
