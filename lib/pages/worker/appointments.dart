import 'package:barbers/enums/user.dart';
import 'package:barbers/models/appointment.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/worker/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/admin/appointment.dart';
import 'package:barbers/widgets/nav_bars/worker_shop.dart';
import 'package:flutter/material.dart';

class WorkerAppointmentsPage extends StatefulWidget {
  final Worker worker;
  final BarberShop shop;
  const WorkerAppointmentsPage({
    Key? key,
    required this.shop,
    required this.worker,
  }) : super(key: key);

  @override
  State<WorkerAppointmentsPage> createState() => _WorkerAppointmentsPageState();
}

class _WorkerAppointmentsPageState extends State<WorkerAppointmentsPage> {
  List<Appointment> appointments = [];
  bool dataLoaded = false;

  @override
  initState() {
    setup();
    super.initState();
  }

  Future<void> setup() async {
    // Worker? worker = await Worker.getJob(userId: AppManager.user.id!, shopId: widget.shop.id!);
    // if (worker == null) return;

    final result = await Appointment.getWorkers(shopId: widget.shop.id!, workerId: widget.worker.id!);
    setState(() {
      appointments = result;
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return DefaultTabController(
      length: appointments.length,
      child: Scaffold(
        appBar: BaseAppBar(
          title: AppManager.stringToTitle('randevu'),
          onPressed: () => Pusher.pushAndRemoveAll(context, const WorkerBarberShopsPage()),
        ).build(context),
        body: SafeArea(
          child: SizedBox(
            width: media.size.width,
            child: !dataLoaded
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => AdminAppointmentCard(
                      appointments[index],
                      EUser.worker,
                    ),
                    itemCount: appointments.length,
                  ),
          ),
        ),
        bottomNavigationBar: WorkerShopBottomNav(
          selectedIndex: 1,
          shop: widget.shop,
          worker: widget.worker,
        ),
      ),
    );
  }
}
