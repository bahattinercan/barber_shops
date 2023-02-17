import 'package:flutter/material.dart';

class EditTextButton extends StatefulWidget {
  final String text;
  final String label;
  final void Function()? onTap;
  EditTextButton({
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
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(width: 2.5),
              GestureDetector(
                onTap: widget.onTap,
                child: Icon(Icons.edit),
              ),
            ],
          ),
          SizedBox(height: 2.5),
          Text(widget.text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
