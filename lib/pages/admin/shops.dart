import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/create_shop.dart';
import 'package:barbers/pages/general/home.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/admin/barber_shop.dart';
import 'package:flutter/material.dart';

class AdminBarberShopsPage extends StatefulWidget {
  const AdminBarberShopsPage({Key? key}) : super(key: key);

  @override
  State<AdminBarberShopsPage> createState() => _AdminBarberShopsPageState();
}

class _AdminBarberShopsPageState extends State<AdminBarberShopsPage> {
  late List<BarberShop> shops;
  bool dataLoaded = false;

  @override
  initState() {
    BarberShop.getUserShops(userId: AppManager.user.id!).then((value) {
      setState(() {
        shops = value;
        dataLoaded = true;
      });
    });
    super.initState();
  }

  void _add() {
    Pusher.pushAndRemoveAll(context, const CreateBarberShopPage());
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(
          Icons.add_rounded,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('dükkan'),
        onPressed: () => Pusher.pushAndRemoveAll(context, const HomePage()),
      ).build(context),
      body: SafeArea(
        child: SizedBox(
          width: media.size.width,
          height: media.size.height,
          child: !dataLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => AdminBarberShopCard(
                    shops[index],
                    EUser.boss,
                  ),
                  itemCount: shops.length,
                ),
        ),
      ),
    );
  }
}
