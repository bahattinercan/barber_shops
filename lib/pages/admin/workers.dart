import 'dart:convert';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/cards/admin/worker.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminWorkersPage extends StatefulWidget {
  BarberShop shop;
  bool canDelete;
  bool canRemoveWorker;
  AdminWorkersPage({
    super.key,
    required this.shop,
    this.canDelete = false,
    this.canRemoveWorker = false,
  });

  @override
  State<AdminWorkersPage> createState() => _AdminWorkersPageState();
}

class _AdminWorkersPageState extends State<AdminWorkersPage> {
  List<Worker> workers = [];

  @override
  initState() {
    getData.then((value) {
      setState(() {
        workers = value;
      });
    });
    super.initState();
  }

  updateCafe(BarberShop shop) {
    widget.shop = shop;
  }

  Future<List<Worker>> get getData async {
    try {
      String datas = "";
      datas = await Requester.getReq('/workers/shop/${widget.shop.id}');

      return workerListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
  }

  void UpdateWorker(Worker worker) {
    setState(() {
      worker;
    });
  }

  void removeWorker(worker) => setState(() => workers.remove(worker));

  void addWorkerButton() {
    AppManager.bottomSheet(
      context,
      TextFieldBS(
        submit: addWorker,
        hintText: "xxxx@gmail.com",
        labelText: "email",
        keyboardType: TextInputType.emailAddress,
        validator: ValidatorManager.emailValidator,
        maxLength: 60,
      ),
    );
  }

  addWorker(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      // find user
      final hasEmailRes = await Requester.getReq("/users/has_email/${text}");
      if (Requester.resultNotifier.value is RequestLoadFailure) {
        Dialogs.failDialog(context: context);
        return;
      }
      int userId = jsonDecode(hasEmailRes)["id"];

      // check if this user is already added
      if (workers.any((element) => element.id == userId)) return;

      // add to the cafe
      final workerRes = await Requester.postReq(
          "/workers",
          workerToJson(Worker(
            userId: userId,
            barberShopId: widget.shop.id,
          )));

      // check for the result
      if (Requester.resultNotifier.value is RequestLoadFailure) {
        Dialogs.failDialog(context: context);
        return;
      }
      Worker newWorker = workerFromJson(workerRes);
      // add to the list
      setState(() {
        workers.add(newWorker);
      });

      Navigator.pop(context);
      Dialogs.successDialog(context: context);
    } catch (e) {
      Dialogs.failDialog(context: context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('çalışan'),
        onPressed: () => Pusher.pushAndRemoveAll(context, AdminBarberShopsPage()),
        actions: [IconButton(onPressed: addWorkerButton, icon: Icon(Icons.add_rounded))],
      ).build(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          width: media.size.width,
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return AdminWorkerCard(
                    workers[index],
                    canRemoveWorker: widget.canRemoveWorker,
                    shopId: widget.shop.id!,
                    removeWorker: removeWorker,
                  );
                },
                itemCount: workers.length,
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: AdminBarberShopBottomNB(
        selectedIndex: 2,
        shop: widget.shop,
      ),
    );
  }
}
