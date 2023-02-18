import 'package:barbers/enums/user.dart';
import 'package:barbers/models/user.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WorkerCard extends StatefulWidget {
  User user;
  int cafeId;

  /// if true then you needed to specify removeWorker function.
  bool canRemoveWorker;
  void Function(int uid) removeWorker;
  WorkerCard(
    this.user, {
    super.key,
    this.canRemoveWorker = false,
    required this.removeWorker,
    required this.cafeId,
  });

  @override
  State<WorkerCard> createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  bool isActive = true;

  changeUserType(EUser userType) {
    setState(() {
      widget.user.setType(userType);
    });
  }

  Color get userColor {
    switch (widget.user.getType) {
      case EUser.normal:
        if (widget.user.authority!)
          return Colors.grey.shade700;
        else
          return Colors.grey.shade300;

      case EUser.worker:
        if (widget.user.authority!)
          return Colors.green;
        else
          return Colors.red;

      case EUser.boss:
        if (widget.user.authority!)
          return Colors.blue;
        else
          return Colors.amber.shade900;

      case EUser.admin:
        if (widget.user.authority!)
          return Colors.purple;
        else
          return Colors.purple.shade300;
    }
  }

  removeWorkerButton() async {
    Dialogs.yesNoDialog(context, "Çıkart", "Çalışan çıkartılsın mı?", okF: removeWorker);
  }

  removeWorker() async {
    await HttpReqManager.putReq("/cafes/remove_worker/${widget.cafeId}/${widget.user.id}", null);
    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Dialogs.failDialog(context: context);
      return;
    }
    setState(() {
      isActive = false;
    });
    widget.removeWorker(widget.user.id!);
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
                        color: userColor,
                      ),
                    ),
                    title: Text(
                      widget.user.fullname!,
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
                      "Rol : " + widget.user.getType.name,
                      style: TextStyle(color: Colors.black),
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
