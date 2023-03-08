import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/worker/change_work_times.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/buttons/base_popup_menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminWorkerCard extends StatefulWidget {
  Worker worker;
  int shopId;

  /// if true then you needed to specify removeWorker function.
  bool canRemoveWorker;
  void Function(Worker worker)? removeWorker;
  AdminWorkerCard(
    this.worker, {
    super.key,
    this.canRemoveWorker = false,
    this.removeWorker,
    required this.shopId,
  });

  @override
  State<AdminWorkerCard> createState() => _AdminWorkerCardState();
}

class _AdminWorkerCardState extends State<AdminWorkerCard> {
  bool isActive = true;

  Color get iconColor {
    return Colorer.primaryVariant;
  }

  removeWorkerButton() async {
    Dialogs.yesNoDialog(context, "Çıkart", "Çalışan çıkartılsın mı?", okF: removeWorker);
  }

  removeWorker() async {
    bool res = await Worker.delete(id: widget.worker.id!);
    if (!res) {
      Dialogs.failDialog(context: context);
      return;
    }
    setState(() {
      isActive = false;
    });
    if (widget.removeWorker != null) widget.removeWorker!(widget.worker);
  }

  void changeWorkTimesButton() {
    Pusher.push(context, ChangeWorkTimesPage(worker: widget.worker, shopId: widget.shopId));
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
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: iconColor,
                      ),
                    ),
                    title: Text(
                      widget.worker.fullname!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colorer.onSurface,
                      ),
                    ),
                    trailing: BasePopupMenuButton(itemBuilder: (context) {
                      return [
                        if (widget.canRemoveWorker)
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Text(
                              "Çalışma Zamanları",
                              style: TextStyle(
                                color: Colorer.onSurface,
                              ),
                            ),
                          ),
                        const PopupMenuItem<int>(
                          value: 99,
                          child: Text(
                            "Çıkart",
                            style: TextStyle(
                              color: Colorer.onSurface,
                            ),
                          ),
                        ),
                      ];
                    }, onSelected: (value) {
                      switch (value) {
                        case 1:
                          changeWorkTimesButton();
                          break;
                        case 99:
                          removeWorkerButton();
                          break;
                        default:
                      }
                    }),
                    subtitle: Text(
                      "Tel : " + widget.worker.phoneNo!,
                      style: TextStyle(
                        color: Colorer.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
