import 'package:barbers/models/user.dart';
import 'package:barbers/pages/login.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:barbers/widgets/text_form_fields/password.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _surnameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _telC = TextEditingController();
  String? countryValue;
  String? stateValue;
  String? cityValue;

  Future<void> _signInButton() async {
    if (!_formKey.currentState!.validate()) return;
    if (countryValue == null || stateValue == null || cityValue == null) {
      Dialogs.failDialog(context: context, content: "Konum bilgilerinizi kontrol edin");
      return;
    }

    await HttpReqManager.postReq(
      "/users/sign_in",
      userToJson(
        User(
          email: _emailC.text,
          password: _passwordC.text,
          fullname: "${_nameC.text} ${_surnameC.text}",
          phoneNo: _telC.text,
          country: countryValue,
          province: stateValue,
          district: cityValue,
        ),
      ),
    );
    if (HttpReqManager.resultNotifier.value is RequestLoadSuccess) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void _loginButton() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  BaseTextFormField(
                    controller: _nameC,
                    icon: Icons.person,
                    hintText: "İsim",
                    labelText: "İsim *",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _surnameC,
                    icon: Icons.person,
                    hintText: "Soyisim",
                    labelText: "Soyisim *",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailC,
                    icon: Icons.email,
                    hintText: "Email@example.com",
                    labelText: "Email *",
                    validator: ValidatorManager.emailValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordTextFormField(
                    controller: _passwordC,
                    icon: Icons.lock,
                    hintText: "Şifre",
                    labelText: "Şifre *",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _telC,
                    icon: Icons.phone,
                    hintText: "5xx xxx xx xx",
                    labelText: "Tel no",
                    validator: ValidatorManager.phoneOptionalValidator,
                    maxLength: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectState(
                    onCountryChanged: (value) {
                      if (value == "Ülke Seç")
                        countryValue = null;
                      else
                        countryValue = value;
                    },
                    onStateChanged: (value) {
                      if (value == "Şehir Seç")
                        stateValue = null;
                      else
                        stateValue = value;
                    },
                    onCityChanged: (value) {
                      if (value == "İlçe Seç")
                        cityValue = null;
                      else
                        cityValue = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: _loginButton,
                          child: const Text(
                            "Üye misiniz? Giriş Yap",
                          )),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: _signInButton,
                          child: const Text('Kayıt ol'),
                        ),
                      ),
                    ],
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
