// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/user.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';

class ResetPasswordBS extends StatefulWidget {
  const ResetPasswordBS({super.key});

  @override
  State<ResetPasswordBS> createState() => _ResetPasswordBSState();
}

class _ResetPasswordBSState extends State<ResetPasswordBS> {
  final _formKey = GlobalKey<FormState>();
  final _newPass = TextEditingController();
  final _newPass2 = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (_newPass.text != _newPass2.text) {
      Dialogs.failDialog(context: context, content: "Yeni şifreler eşleşmiyor");
      return;
    }

    final result = await User.resetPassword(id: AppManager.user.id!, password: _newPass.text);

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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PasswordTextFormField(
                controller: _newPass,
                icon: Icons.lock_outline,
                labelText: "şifre *",
                hintText: '*******',
              ),
              const SizedBox(height: 10),
              PasswordTextFormField(
                controller: _newPass2,
                icon: Icons.lock_outline,
                labelText: "tekrar şifre *",
                hintText: '*******',
              ),
              ElevatedButton(
                onPressed: () => _submitData(context),
                child: const Text("Onayla"),
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
