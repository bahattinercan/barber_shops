import 'package:barbers/models/user.dart';
import 'package:barbers/pages/home.dart';
import 'package:barbers/pages/signin.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/authority_manager.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/secure_storage_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/custom.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  Future<void> _loginButton() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      final result = await HttpReqManager.postReq(
        "/users/login",
        userToJson(User(email: _emailTextController.text, password: _passwordTextController.text)),
      );
      if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
        Dialogs.failDialog(context: context, content: "Hatalı giriş");
        return;
      }
      // set user data
      AppManager.user = userFromJson(result);
      // update authority
      AuthorityController.instance.hasAuthority = AppManager.user.authority!;
      // set headers token
      HttpReqManager.addTokenToHeaders(AppManager.user.accessToken!);
      // storage the token
      SecureStorageController.writeWithKey(StoreKeyType.access_token, AppManager.user.accessToken!);
      // push the home page
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    } catch (e) {
      print(e);
    }
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
              child: Text("Telefon")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //AppController.instance.bottomSheet(context, ForgetPasswordEmailBS());
              },
              child: Text("Email")),
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
                  SizedBox(height: 25),
                  CustomTextFormField(
                    controller: _emailTextController,
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
                    controller: _passwordTextController,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                          }),
                          child: const Text(
                            "Yeni kullanıcı? Kullanıcı oluştur",
                          )),
                      Container(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: _loginButton,
                          child: const Text('Giriş'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
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
