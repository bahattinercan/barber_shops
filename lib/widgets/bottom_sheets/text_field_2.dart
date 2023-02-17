import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:flutter/material.dart';

class TextField2BS extends StatefulWidget {
  final Function(
    GlobalKey<FormState> formKey,
    String text,
    String text2,
  ) submit;
  final Function(TextEditingController controller)? onStart;
  // textField 1
  final TextInputType? keyboardType;
  final dynamic icon;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final int? maxLength;
  // textField 2
  final TextInputType? keyboardType2;
  final dynamic icon2;
  final String? hintText2;
  final String? labelText2;
  final String? Function(String?)? validator2;
  final int? maxLength2;

  final String buttonText;
  const TextField2BS({
    required this.submit,
    this.onStart,
    // text field 1
    this.keyboardType,
    this.validator,
    this.icon,
    this.hintText,
    this.labelText,
    this.maxLength,
    // text field 2
    this.keyboardType2,
    this.validator2,
    this.icon2,
    this.hintText2,
    this.labelText2,
    this.maxLength2,
    this.buttonText = "Değiştir",
    super.key,
  });

  @override
  State<TextField2BS> createState() => _TextField2BSState();
}

class _TextField2BSState extends State<TextField2BS> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.onStart == null ? null : widget.onStart!(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BaseTextFormField(
                autofocus: true,
                keyboardType: widget.keyboardType,
                icon: widget.icon != null ? widget.icon : Icons.text_fields,
                hintText: widget.hintText != null ? widget.hintText! : "",
                labelText: widget.labelText != null ? widget.labelText! : "",
                controller: _controller,
                validator: (value) =>
                    widget.validator != null ? widget.validator!(value) : ValidatorManager.baseValidator(value),
                maxLength: widget.maxLength,
              ),
              SizedBox(height: 5),
              BaseTextFormField(
                keyboardType: widget.keyboardType2,
                icon: widget.icon2 != null ? widget.icon2 : Icons.text_fields,
                hintText: widget.hintText2 != null ? widget.hintText2! : "",
                labelText: widget.labelText2 != null ? widget.labelText2! : "",
                controller: _controller2,
                validator: (value) =>
                    widget.validator2 != null ? widget.validator2!(value) : ValidatorManager.baseValidator(value),
                maxLength: widget.maxLength2,
              ),
              SizedBox(height: 5),
              BaseButton(
                text: widget.buttonText,
                onPressed: () => widget.submit(_formKey, _controller.text, _controller2.text),
              ),
              SizedBox(
                height: 2.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
