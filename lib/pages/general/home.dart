import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/pages/general/appointments.dart';
import 'package:barbers/pages/general/profile.dart';
import 'package:barbers/pages/worker/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/authority_manager.dart';
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

  openAdminPanel() {
    if (!Authorization.isWorker) {
      Dialogs.customDialog(
          context: context,
          title: "Sayfa seç",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseButton(
                text: "Müdür",
                onPressed: () => Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage()),
              ),
              BaseButton(
                text: "Çalışan",
                onPressed: () => Pusher.pushAndRemoveAll(context, const WorkerBarberShopsPage()),
              ),
              if (Authorization.isAdmin)
                BaseButton(
                  text: "Admin",
                  onPressed: () {},
                ),
            ],
          ));
    } else {
      Pusher.pushAndRemoveAll(context, const WorkerBarberShopsPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Şuanki konum",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colorer.onBackground),
            ),
            Text(
              '${AppManager.user.provinceToString()}, ${AppManager.user.districtToString()}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colorer.onBackground),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmarks_rounded,
              color: Colorer.onBackground,
            ),
            onPressed: () => Pusher.push(context, const AppointmentsPage()),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Colorer.onBackground,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.person_rounded,
                  color: Colorer.primaryVariant,
                  size: 32,
                ),
                onPressed: () => Pusher.push(context, const ProfilePage()),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Authorization.isNormal
          ? null
          : FloatingActionButton(
              onPressed: openAdminPanel,
              child: const Icon(
                Icons.admin_panel_settings_rounded,
                size: 36,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: !dataLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
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
