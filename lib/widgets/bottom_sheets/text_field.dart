import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldBS extends StatefulWidget {
  final Function(
    GlobalKey<FormState> formKey,
    String text,
  ) submit;
  final Function(TextEditingController controller)? onStart;
  final TextInputType? keyboardType;
  final dynamic icon;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final String titleText;
  final String buttonText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const TextFieldBS({
    required this.submit,
    this.onStart,
    this.keyboardType,
    this.validator,
    this.titleText = "Değiştir",
    this.buttonText = "Değiştir",
    this.icon,
    this.hintText,
    this.labelText,
    this.maxLength,
    this.inputFormatters,
    super.key,
  });

  @override
  State<TextFieldBS> createState() => _TextFieldBSState();
}

class _TextFieldBSState extends State<TextFieldBS> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.onStart == null ? null : widget.onStart!(_controller);
  }

  // Future<void> _submitData(BuildContext context) async {
  //   try {
  //     if (!_formKey.currentState!.validate()) return;
  //     bool result = await HttpReqManager.putReq(
  //       "/anvil_keys/set_data/${widget.anvil_key.id!}/key",
  //       jsonEncode({"data": _keyT.text}),
  //     );
  //     if (result) {
  //       Navigator.pop(context);
  //       setState(() {
  //         widget.anvil_key.key = _keyT.text;
  //       });
  //       widget.editF(_keyT.text);
  //       WidgetController.successDialog(context: context);
  //     } else {
  //       WidgetController.failDialog(context: context);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
            children: [
              BaseTextFormField(
                autofocus: true,
                keyboardType: widget.keyboardType,
                icon: widget.icon != null ? widget.icon : null,
                hintText: widget.hintText != null ? widget.hintText! : "",
                labelText: widget.labelText != null ? widget.labelText! : "",
                controller: _controller,
                validator: (value) =>
                    widget.validator != null ? widget.validator!(value) : ValidatorManager.baseValidator(value),
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters,
              ),
              SizedBox(height: 5),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => widget.submit(_formKey, _controller.text),
                  child: Text(widget.buttonText),
                ),
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
