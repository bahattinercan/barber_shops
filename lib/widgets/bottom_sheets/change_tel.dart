// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/user.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:flutter/material.dart';

class ChangeTelBS extends StatefulWidget {
  const ChangeTelBS({super.key});

  @override
  State<ChangeTelBS> createState() => _ChangeTelBSState();
}

class _ChangeTelBSState extends State<ChangeTelBS> {
  final _formKey = GlobalKey<FormState>();
  final _oldPhone = TextEditingController();
  final _newPhone = TextEditingController();
  final _newPhone2 = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (_newPhone2.text != _newPhone.text) {
      Dialogs.failDialog(context: context, content: "Yeni telefonlar eşleşmiyor");
      return;
    }

    final result = await User.changePhone(
      id: AppManager.user.id!,
      phone: _oldPhone.text,
      oldPhone: _newPhone.text,
    );
    if (result) {
      Dialogs.successDialog(context: context, okFunction: () => Navigator.of(context).pop());
    } else {
      Dialogs.failDialog(context: context, okFunction: () => Navigator.of(context).pop());
    }
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
                controller: _oldPhone,
                icon: Icons.phone_rounded,
                labelText: "eski tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              BaseTextFormField(
                controller: _newPhone,
                icon: Icons.phone_outlined,
                labelText: "yeni tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 10,
              ),
              BaseTextFormField(
                controller: _newPhone2,
                icon: Icons.phone_outlined,
                labelText: "tekrar tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 175,
                child: ElevatedButton(
                  onPressed: () => _submitData(context),
                  child: const Text("Değiştir"),
                ),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
