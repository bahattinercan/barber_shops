import 'package:barbers/enums/user.dart';
import 'package:barbers/models/appointment.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/custom_formats.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/widgets/buttons/base_popup_menu.dart';
import 'package:flutter/material.dart';

enum ECafeCard {
  boss,
  worker,
}

// ignore: must_be_immutable
class AdminAppointmentCard extends StatefulWidget {
  EUser eUser;
  Appointment appointment;
  AdminAppointmentCard(this.appointment, this.eUser, {super.key});

  @override
  State<AdminAppointmentCard> createState() => _AdminAppointmentCardState();
}

class _AdminAppointmentCardState extends State<AdminAppointmentCard> {
  bool isActive = true;

  updateCafe(Appointment appointment) {
    setState(() {
      widget.appointment = appointment;
    });
  }

  delete(int id) async {
    final request = await HttpReqManager.deleteReq("/barber_shops/${id}");
    if (request) {
      setState(() => isActive = false);
      Dialogs.successDialog(context: context);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  deleteButton(int id) {
    Dialogs.yesNoDialog(context, "Randevu'yu sil", "Randevu silinsin mi?", okF: () => delete(id));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isActive,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 2.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    minLeadingWidth: 12,
                    minVerticalPadding: 6,
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    leading: IconButton(
                      color: ColorManager.primaryVariant,
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_rounded),
                    ),
                    title: Text(
                      "Müşteri: " + widget.appointment.customerName!,
                      style: TextStyle(fontWeight: FontWeight.w700, color: ColorManager.onSurface),
                    ),
                    trailing: BasePopupMenuButton(itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                            value: 99,
                            child: Text(
                              "Sil",
                              style: TextStyle(
                                color: ColorManager.onSurface,
                              ),
                            )),
                      ];
                    }, onSelected: (value) {
                      switch (value) {
                        case 99:
                          deleteButton(widget.appointment.id!);
                          break;
                        default:
                      }
                    }),
                    subtitle: Text(
                      "Tel: " +
                          widget.appointment.customerPhone! +
                          "\nBerber:" +
                          widget.appointment.barberName! +
                          "\nTarih:" +
                          CustomFormats.time.format(widget.appointment.time!),
                      style: TextStyle(fontWeight: FontWeight.w500, color: ColorManager.onSurface),
                    ),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}