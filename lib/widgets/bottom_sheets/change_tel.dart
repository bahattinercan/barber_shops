import 'dart:convert';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
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
  final _oldPhoneC = TextEditingController();
  final _newPhoneC = TextEditingController();
  final _newPhone2C = TextEditingController();

  Future<void> _submitData(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) return;
      if (_newPhone2C.text != _newPhoneC.text) return;

      final uid = AppManager.user.id;

      final result = await HttpReqManager.putReq(
        "/users/change_phone_no/$uid",
        jsonEncode({"oldPhoneNo": _oldPhoneC.text, "phoneNo": _newPhoneC.text}),
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
                controller: _oldPhoneC,
                icon: Icons.phone_rounded,
                labelText: "eski tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 10,
              ),
              BaseTextFormField(
                controller: _newPhoneC,
                icon: Icons.phone_outlined,
                labelText: "yeni tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 10,
              ),
              BaseTextFormField(
                controller: _newPhone2C,
                icon: Icons.phone_outlined,
                labelText: "tekrar tel no *",
                hintText: "5xx xxx xxxx",
                maxLength: 10,
                validator: ValidatorManager.phoneValidator,
                keyboardType: TextInputType.phone,
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
