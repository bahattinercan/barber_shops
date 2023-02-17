import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ResetPasswordBS extends StatefulWidget {
  const ResetPasswordBS({super.key});

  @override
  State<ResetPasswordBS> createState() => _ResetPasswordBSState();
}

class _ResetPasswordBSState extends State<ResetPasswordBS> {
  final _formKey = GlobalKey<FormState>();
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
      final result = await HttpReqManager.putReq(
        "/users/reset_password/${AppManager.user.id}",
        json.encode({"password": _newPasswordC.text}),
      );

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
                controller: _newPasswordC,
                icon: Icons.lock_outline,
                labelText: "şifre *",
                hintText: '*******',
              ),
              SizedBox(height: 10),
              PasswordTextFormField(
                controller: _newPasswordC2,
                icon: Icons.lock_outline,
                labelText: "tekrar şifre *",
                hintText: '*******',
              ),
              ElevatedButton(
                onPressed: () => _submitData(context),
                child: const Text("Onayla"),
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
