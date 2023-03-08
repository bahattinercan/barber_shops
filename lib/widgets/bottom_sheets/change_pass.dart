// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/user.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';

class ChangePasswordBS extends StatefulWidget {
  const ChangePasswordBS({super.key});

  @override
  State<ChangePasswordBS> createState() => _ChangePasswordBSState();
}

class _ChangePasswordBSState extends State<ChangePasswordBS> {
  final _formKey = GlobalKey<FormState>();
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _newPass2 = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (_newPass.text != _newPass2.text) {
      Dialogs.failDialog(context: context, content: "Yeni şifreler eşleşmiyor");
      return;
    }

    final result = await User.changePassword(
      id: AppManager.user.id!,
      newPassword: _newPass.text,
      password: _oldPass.text,
    );
    if (result) {
      Dialogs.successDialog(context: context, okFunction: () => Navigator.pop(context));
    } else {
      Dialogs.failDialog(context: context, okFunction: () => Navigator.pop(context));
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
              PasswordTextFormField(
                controller: _oldPass,
                icon: Icons.lock_rounded,
                labelText: "eski şifre *",
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordTextFormField(
                controller: _newPass,
                icon: Icons.lock_outline,
                labelText: "şifre *",
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordTextFormField(
                controller: _newPass2,
                icon: Icons.lock_outline,
                labelText: "tekrar şifre *",
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
