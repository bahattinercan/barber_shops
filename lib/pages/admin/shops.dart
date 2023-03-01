import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/create_shop.dart';
import 'package:barbers/pages/home.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/requester.dart';
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
  late Future<List<BarberShop>> shops;

  @override
  initState() {
    shops = getData();
    super.initState();
  }

  Future<List<BarberShop>> getData() async {
    final datas = await Requester.getReq('/barber_shops/my/${AppManager.user.id}');
    return barberShopListFromJson(datas);
  }

  void _add() {
    Pusher.pushAndRemoveAll(context, CreateBarberShopPage());
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(
          Icons.add_rounded,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('dükkan'),
        onPressed: () => Pusher.pushAndRemoveAll(context, HomePage()),
      ).build(context),
      body: SafeArea(
        child: Container(
          width: media.size.width,
          child: Column(children: [
            Expanded(
              child: FutureBuilder(
                future: shops,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data == null
                        ? Container()
                        : ListView.builder(
                            itemBuilder: (context, index) => AdminBarberShopCard(
                              snapshot.data![index],
                              EUser.boss,
                            ),
                            itemCount: snapshot.data!.length,
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
