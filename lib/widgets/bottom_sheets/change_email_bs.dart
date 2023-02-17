import 'dart:convert';

import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/custom.dart';
import 'package:flutter/material.dart';

class ChangeEmailBS extends StatefulWidget {
  const ChangeEmailBS({super.key});

  @override
  State<ChangeEmailBS> createState() => _ChangeEmailBSState();
}

class _ChangeEmailBSState extends State<ChangeEmailBS> {
  final _formKey = GlobalKey<FormState>();
  final _oldEmailC = TextEditingController();
  final _newEmailC = TextEditingController();
  final _newEmailC2 = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) return;
      if (_newEmailC.text != _newEmailC2.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Yeni emailler eşleşmiyor')),
        );
        return;
      }

      final result = await HttpReqManager.putReq(
        "/users/change_email/${AppManager.user.id}",
        jsonEncode({
          "email": _oldEmailC.text,
          "new_email": _newEmailC.text,
        }),
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
              CustomTextFormField(
                controller: _oldEmailC,
                labelText: "eski e-mail *",
                icon: Icons.email_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: ValidatorManager.emailValidator,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: _newEmailC,
                labelText: "e-mail *",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: ValidatorManager.emailValidator,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: _newEmailC2,
                labelText: "tekrar e-mail *",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: ValidatorManager.emailValidator,
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
