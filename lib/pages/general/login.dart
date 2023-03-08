// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/user.dart';
import 'package:barbers/pages/general/home.dart';
import 'package:barbers/pages/general/signin.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/authority_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/utils/secure_storager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> _loginButton() async {
    if (!_formKey.currentState!.validate()) return;

    User? user = await User.login(email: _email.text, password: _password.text);
    if (user == null) {
      Dialogs.failDialog(context: context, content: "Hatalı giriş");
      return;
    }
    // update authority
    Authorization.hasAuthority = AppManager.user.authority!;
    // set headers token
    Requester.addTokenToHeaders(AppManager.user.accessToken!);
    // storage the token
    SecureStorager.writeWithKey(StoreKeyType.accessToken, AppManager.user.accessToken!);
    // push the home page
    Pusher.pushAndRemoveAll(context, const HomePage());
  }

  void _didYouForgetPassword() {
    Dialogs.customDialog(
      context: context,
      title: "Kod Nereye Gönderilsin?",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //AppController.instance.bottomSheet(context, ForgetPasswordPhoneBS());
              },
              child: const Text("Telefon")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //AppController.instance.bottomSheet(context, ForgetPasswordEmailBS());
              },
              child: const Text("Email")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/images/test.png',
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  BaseTextFormField(
                    controller: _email,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email_rounded,
                    hintText: "deneme@gmail.com",
                    labelText: "e-mail *",
                    validator: ValidatorManager.emailValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordTextFormField(
                    controller: _password,
                    icon: Icons.lock_rounded,
                    labelText: "şifre *",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                          }),
                          child: const Text(
                            "Yeni kullanıcı? Kullanıcı oluştur",
                          )),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: _loginButton,
                          child: const Text('Giriş'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _didYouForgetPassword,
                      child: const Text(
                        "Şifreni mi unuttun?",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
