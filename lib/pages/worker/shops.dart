import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/general/home.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/admin/barber_shop.dart';
import 'package:flutter/material.dart';

class WorkerBarberShopsPage extends StatefulWidget {
  const WorkerBarberShopsPage({Key? key}) : super(key: key);

  @override
  State<WorkerBarberShopsPage> createState() => _WorkerBarberShopsPageState();
}

class _WorkerBarberShopsPageState extends State<WorkerBarberShopsPage> {
  List<BarberShop> shops = [];
  bool dataLoaded = false;

  @override
  initState() {
    data.then((value) {
      setState(() {
        shops = value;
        dataLoaded = true;
      });
    });
    super.initState();
  }

  Future<List<BarberShop>> get data async {
    // TODO değiştir
    final datas = await Requester.getReq('/barber_shops/my/${AppManager.user.id}');
    return barberShopListFromJson(datas);
  }

  Future<List<Worker>> get workerData async {
    try {
      final datas = await Requester.getReq('/workers/jobs/${AppManager.user.id}');
      return workerListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('dükkan'),
        onPressed: () => Pusher.pushAndRemoveAll(context, HomePage()),
      ).build(context),
      body: SafeArea(
        child: Container(
          width: media.size.width,
          height: media.size.height,
          child: !dataLoaded
              ? Center(
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
