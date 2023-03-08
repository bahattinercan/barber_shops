import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/pages/general/appointments.dart';
import 'package:barbers/pages/general/profile.dart';
import 'package:barbers/pages/worker/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:barbers/widgets/cards/barber_shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BarberShop> _shops = [];
  bool dataLoaded = false;

  @override
  initState() {
    BarberShop.getNearby(
      country: AppManager.user.country!,
      province: AppManager.user.province!,
      district: AppManager.user.district!,
    ).then((value) {
      setState(() {
        _shops = value;
        dataLoaded = true;
      });
    });
    super.initState();
  }

  adminButton() {
    if (AppManager.user.getType == EUser.boss) {
      Dialogs.customDialog(
          context: context,
          title: "Sayfa seç",
          content: Column(
            children: [
              BaseButton(
                text: "Müdür",
                onPressed: () => Pusher.pushAndRemoveAll(context, AdminBarberShopsPage()),
              ),
              BaseButton(
                text: "Çalışan",
                onPressed: () => Pusher.pushAndRemoveAll(context, WorkerBarberShopsPage()),
              ),
            ],
          ));
    } else {
      Pusher.pushAndRemoveAll(context, WorkerBarberShopsPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Şuanki konum",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colorer.onBackground),
            ),
            Text(
              '${AppManager.user.provinceToString()}, ${AppManager.user.districtToString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colorer.onBackground),
            ),
          ],
        ),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(
                Icons.bookmarks_rounded,
                color: Colorer.onBackground,
              ),
              onPressed: () => Pusher.push(context, AppointmentsPage()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colorer.onBackground,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person_rounded,
                  color: Colorer.primaryVariant,
                  size: 32,
                ),
                onPressed: () => Pusher.push(context, ProfilePage()),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppManager.user.getType == EUser.normal
          ? null
          : FloatingActionButton(
              onPressed: adminButton,
              child: Icon(
                Icons.admin_panel_settings_rounded,
                size: 36,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: !dataLoaded
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: _shops.length,
                  itemBuilder: (context, index) {
                    return BarberShopCard(
                      shop: _shops[index],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
