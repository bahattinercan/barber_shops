import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/barber_shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BarberShop> _shops = [];

  @override
  initState() {
    getData().then((value) => setState(() => _shops = value));
    super.initState();
  }

  Future<List<BarberShop>> getData() async {
    final datas = await HttpReqManager.postReq(
        '/barber_shops/nearby',
        barberShopToJson(BarberShop(
          country: AppManager.user.country,
          province: AppManager.user.province,
          district: AppManager.user.district,
        )));
    return barberShopListFromJson(datas);
  }

  adminButton() {
    PushManager.pushAndRemoveAll(context, AdminBarberShopsPage());
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorManager.onBackground),
            ),
            Text(
              '${AppManager.user.provinceToString()}, ${AppManager.user.districtToString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ColorManager.onBackground),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.onBackground,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person_rounded,
                  color: ColorManager.primaryVariant,
                  size: 32,
                ),
                onPressed: () {
                  // Add your onPressed callback here
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adminButton,
        child: Icon(
          Icons.admin_panel_settings_rounded,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: _shops.length,
                  itemBuilder: (context, index) {
                    return BarberShopCard(
                      shop: _shops[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
