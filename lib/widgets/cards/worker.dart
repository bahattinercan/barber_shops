import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorkerCard extends StatefulWidget {
  Worker worker;
  int shopId;

  /// if true then you needed to specify removeWorker function.
  bool canRemoveWorker;
  void Function(Worker worker)? removeWorker;
  WorkerCard(
    this.worker, {
    super.key,
    this.canRemoveWorker = false,
    this.removeWorker,
    required this.shopId,
  });

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  bool isActive = true;

  Color get iconColor {
    return MainColors.triadic_1;
  }

  removeWorkerButton() async {
    Dialogs.yesNoDialog(context, "Çıkart", "Çalışan çıkartılsın mı?", okF: removeWorker);
  }

  removeWorker() async {
    await HttpReqManager.deleteReq("/workers/${widget.worker.id}");
    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Dialogs.failDialog(context: context);
      return;
    }
    setState(() {
      isActive = false;
    });
    if (widget.removeWorker != null) widget.removeWorker!(widget.worker);
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: PopupMenuButton(itemBuilder: (context) {
                      return [
                        if (widget.canRemoveWorker) const PopupMenuItem<int>(value: 98, child: Text("Çıkart")),
                      ];
                    }, onSelected: (value) {
                      switch (value) {
                        case 98:
                          removeWorkerButton();
                          break;
                        default:
                      }
                    }),
                    subtitle: Text(
                      "Tel : " + widget.worker.phoneNo!,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
