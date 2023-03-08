// ignore_for_file: deprecated_member_use

import 'package:barbers/models/user.dart';
import 'package:barbers/pages/general/home.dart';
import 'package:barbers/pages/general/login.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/authority_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/utils/secure_storager.dart';
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
    final old_token = await SecureStorager.readWithKey(StoreKeyType.access_token);
    if (old_token == null || old_token == "") {
      Pusher.pushAndRemoveAll(context, LoginPage());
      return;
    }
    Requester.addTokenToHeaders(old_token);
    final result = await User.tokenLogin(token: old_token);
    if (result == null) {
      Pusher.pushAndRemoveAll(context, LoginPage());
      return;
    }
    // set user data
    AppManager.user = result;
    // update authority
    Authorization.hasAuthority = AppManager.user.authority!;
    // set headers token
    Requester.addTokenToHeaders(AppManager.user.accessToken!);
    // storage the token
    SecureStorager.writeWithKey(StoreKeyType.access_token, AppManager.user.accessToken!);
    Pusher.pushAndRemoveAll(context, HomePage());
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
              height: 20,
            ),
            Container(
              width: 215,
              child: Divider(
                color: Colorer.primary,
                thickness: 5,
              ),
            ),
            Text(
              "BERBERLER",
              style: TextStyle(color: Colorer.primaryVariant, fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 215,
              child: Divider(
                color: Colorer.primary,
                thickness: 5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.alarm,
              size: 36,
              color: Colorer.primaryVariant,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Rowleyes",
              style: TextStyle(
                color: Colorer.primaryVariant,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
