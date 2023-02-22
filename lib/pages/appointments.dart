import 'package:barbers/enums/user.dart';
import 'package:barbers/models/appointment.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/admin/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
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
    final datas = await HttpReqManager.getReq('/appointments/my/${AppManager.user.id}');
    return appointmentListFromJson(datas);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('randevu'),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: Container(
          width: media.size.width,
          height: media.size.height,
          child: ListView.builder(
            itemBuilder: (context, index) => AdminAppointmentCard(
              appointments[index],
              EUser.normal,
            ),
            itemCount: appointments.length,
          ),
        ),
      ),
    );
  }
}
