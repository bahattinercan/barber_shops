// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:barbers/models/user.dart';
import 'package:barbers/pages/home.dart';
import 'package:barbers/pages/login.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/authority_manager.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/secure_storage_manager.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  initState() {
    super.initState();
    tokenLogin();
  }

  Future<void> tokenLogin() async {
    final old_token = await SecureStorageController.readWithKey(StoreKeyType.access_token);
    if (old_token == null || old_token == "") {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
      return;
    }
    HttpReqManager.addTokenToHeaders(old_token);
    final result = await HttpReqManager.postReq("/users/token_login", jsonEncode({"access_token": "$old_token"}));
    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            SizedBox(
              height: 5,
            ),
            Text(
              "Kafeni Bul",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Domates",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
