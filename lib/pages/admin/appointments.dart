import 'package:barbers/enums/user.dart';
import 'package:barbers/models/appointment.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/admin/appointment.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';

class AdminAppointmentsPage extends StatefulWidget {
  final BarberShop shop;
  const AdminAppointmentsPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<AdminAppointmentsPage> createState() => _AdminAppointmentsPageState();
}

class _AdminAppointmentsPageState extends State<AdminAppointmentsPage> {
  List<Appointment> appointments = [];
  List<Worker> workers = [];
  late List<Appointment> sortedApps = [];

  @override
  initState() {
    setup();
    super.initState();
  }

  Future<void> setup() async {
    appointments = await Appointment.getShops(shopId: widget.shop.id!);
    workers = await Worker.getShops(shopId: widget.shop.id!);
    if (workers.isNotEmpty) _sort(workers[0]);
  }

  void tabBarOnTap(int index) {
    _sort(workers[index]);
  }

  void _sort(Worker worker) {
    setState(() {
      sortedApps = appointments.where((element) => element.workerId == worker.id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return DefaultTabController(
      length: workers.length,
      child: Scaffold(
        appBar: BaseAppBar(
          title: AppManager.stringToTitle('randevu'),
          onPressed: () => Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage()),
          bottom: TabBar(
            tabs: workers.map((worker) => Tab(text: worker.fullname)).toList(),
            labelColor: Colorer.onBackground,
            onTap: tabBarOnTap,
            isScrollable: true,
          ),
        ).build(context),
        body: SafeArea(
          child: SizedBox(
            width: media.size.width,
            child: ListView.builder(
              itemBuilder: (context, index) => AdminAppointmentCard(
                sortedApps[index],
                EUser.boss,
              ),
              itemCount: sortedApps.length,
            ),
          ),
        ),
        bottomNavigationBar: AdminBarberShopBottomNB(
          selectedIndex: 3,
          shop: widget.shop,
        ),
      ),
    );
  }
}
