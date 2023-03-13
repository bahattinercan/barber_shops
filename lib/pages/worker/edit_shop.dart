import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/worker/change_work_times.dart';
import 'package:barbers/pages/worker/shop.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/buttons/row_text.dart';
import 'package:flutter/material.dart';

class WorkerShopEditPage extends StatefulWidget {
  final Worker worker;
  final BarberShop shop;
  const WorkerShopEditPage({
    Key? key,
    required this.shop,
    required this.worker,
  }) : super(key: key);

  @override
  State<WorkerShopEditPage> createState() => _WorkerShopEditPageState();
}

class _WorkerShopEditPageState extends State<WorkerShopEditPage> {
  //#region Functions

  Future<void> isOpen(bool? value) async {
    bool result = await BarberShop.setData(id: widget.shop.id!, column: "is_open", data: value);
    if (result) {
      setState(() => widget.shop.isOpen = value);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  Future<void> isEmpty(bool? value) async {
    bool result = await BarberShop.setData(id: widget.shop.id!, column: "is_empty", data: value);
    if (result) {
      setState(() => widget.shop.isEmpty = value);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle("Düzenle"),
        onPressed: () => backButton(context),
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              RowTextButton(
                text: "Dükkanı aç/kapa",
                iconData: Icons.circle,
                onPressed: () => isOpen(!widget.shop.isOpen!),
                iconColor: widget.shop.isOpen == false ? Colorer.onSurface : Colorer.surface,
              ),
              RowTextButton(
                text: "Dükkan boş/dolu",
                iconData: Icons.circle,
                onPressed: () => isEmpty(!widget.shop.isEmpty!),
                iconColor: widget.shop.isEmpty == false ? Colorer.onSurface : Colorer.surface,
              ),
              RowTextButton(
                text: "Çalışma zamanını değiştir",
                iconData: Icons.circle,
                onPressed: () =>
                    Pusher.push(context, ChangeWorkTimesPage(shopId: widget.shop.id!, worker: widget.worker)),
                iconColor: widget.shop.isEmpty == false ? Colorer.onSurface : Colorer.surface,
              ),
            ],
          ),
        ),
      ),
    );
  }

  backButton(BuildContext context) =>
      Pusher.pushReplacement(context, WorkerShopPage(shop: widget.shop, worker: widget.worker));
}
