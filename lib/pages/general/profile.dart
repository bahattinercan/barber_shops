import 'package:barbers/models/user.dart';
import 'package:barbers/pages/general/login.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/secure_storager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/bottom_sheets/change_email.dart';
import 'package:barbers/widgets/bottom_sheets/change_location.dart';
import 'package:barbers/widgets/bottom_sheets/change_pass.dart';
import 'package:barbers/widgets/bottom_sheets/change_tel.dart';
import 'package:barbers/widgets/buttons/row_text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle("profil"),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              RowTextButton(
                text: "Yeni Şifre",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: () => AppManager.bottomSheet(context, ChangePasswordBS()),
              ),
              RowTextButton(
                text: "Konum Seç",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: () => AppManager.bottomSheet(context, ChangeLocationBS(submit: changeLocation)),
              ),
              RowTextButton(
                text: "Tel No Değiştir",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: () => AppManager.bottomSheet(context, ChangeTelBS()),
              ),
              RowTextButton(
                text: "Email Değiştir",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: () => AppManager.bottomSheet(context, ChangeEmailBS()),
              ),
              RowTextButton(
                text: "Ayarlar",
                iconData: Icons.settings_rounded,
                onPressed: () => null,
              ),
              RowTextButton(
                text: "Çıkış",
                iconData: Icons.logout,
                onPressed: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeLocation(String? countryValue, String? stateValue, String? cityValue) async {
    if (countryValue == null || stateValue == null || cityValue == null) return;
    final res = await User.changeLocation(
      id: AppManager.user.id!,
      country: countryValue,
      province: stateValue,
      district: cityValue,
    );
    if (res) {
      Dialogs.failDialog(context: context);
      return;
    }
    Dialogs.successDialog(context: context);
    setState(() {
      AppManager.user.country = countryValue;
      AppManager.user.province = stateValue;
      AppManager.user.district = cityValue;
    });
  }

  void logout() async {
    await SecureStorager.writeWithKey(StoreKeyType.access_token, "");
    Pusher.pushAndRemoveAll(context, LoginPage());
  }
}
