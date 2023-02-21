import 'package:barbers/enums/user.dart';
import 'package:barbers/models/appointment.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/admin_appointment.dart';
import 'package:flutter/material.dart';

class AdminBarberAppointmentsPage extends StatefulWidget {
  final BarberShop shop;
  const AdminBarberAppointmentsPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<AdminBarberAppointmentsPage> createState() => _AdminBarberAppointmentsPageState();
}

class _AdminBarberAppointmentsPageState extends State<AdminBarberAppointmentsPage> {
  List<Appointment> appointments = [];

  @override
  initState() {
    data.then((value) {
      setState(() {
        appointments = value;
      });
    });
    super.initState();
  }

  Future<List<Appointment>> get data async {
    final datas = await HttpReqManager.getReq('/appointments/shop/${widget.shop.id}');
    return appointmentListFromJson(datas);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name!),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberShopsPage()),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: media.size.width,
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => AdminAppointmentCard(
                  appointments[index],
                  EUser.boss,
                ),
                itemCount: appointments.length,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
