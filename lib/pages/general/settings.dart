import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle("ayarlar"),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
          child: Center(
        child: Text(
          "YAKINDA GELECEK",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colorer.onBackground,
          ),
        ),
      )),
    );
  }
}
