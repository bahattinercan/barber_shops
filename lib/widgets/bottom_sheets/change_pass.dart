import 'dart:convert';

import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';

class ChangePasswordBS extends StatefulWidget {
  const ChangePasswordBS({super.key});

  @override
  State<ChangePasswordBS> createState() => _ChangePasswordBSState();
}

class _ChangePasswordBSState extends State<ChangePasswordBS> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordC = TextEditingController();
  final _newPasswordC = TextEditingController();
  final _newPasswordC2 = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) return;
      if (_newPasswordC.text != _newPasswordC2.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Yeni şifreler eşleşmiyor')),
        );
        return;
      }
      final result = await Requester.putReq(
          "/users/change_password/${AppManager.user.id}",
          jsonEncode({
            "newPassword": _newPasswordC.text,
            "password": _oldPasswordC.text,
          }));

      if (result) {
        Dialogs.successDialog(context: context, okFunction: () => Navigator.of(context).pop());
      } else {
        Dialogs.failDialog(context: context, okFunction: () => Navigator.of(context).pop());
      }
    } catch (e) {
      print(e);
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
                controller: _oldPasswordC,
                icon: Icons.lock_rounded,
                labelText: "eski şifre *",
              ),
              SizedBox(
                height: 10,
              ),
              PasswordTextFormField(
                controller: _newPasswordC,
                icon: Icons.lock_outline,
                labelText: "şifre *",
              ),
              SizedBox(
                height: 10,
              ),
              PasswordTextFormField(
                controller: _newPasswordC2,
                icon: Icons.lock_outline,
                labelText: "tekrar şifre *",
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 175,
                child: ElevatedButton(
                  onPressed: () => _submitData(context),
                  child: const Text("Değiştir"),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
