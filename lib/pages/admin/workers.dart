// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/user.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/cards/admin/worker.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';

class AdminWorkersPage extends StatefulWidget {
  final BarberShop shop;
  final bool canDelete;
  final bool canRemoveWorker;
  const AdminWorkersPage({
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
    Worker.getShops(shopId: widget.shop.id!).then((value) {
      setState(() {
        workers = value;
      });
    });
    super.initState();
  }

  void updateWorker(Worker worker) {
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
    if (!formKey.currentState!.validate()) return;
    // find user
    final userId = await User.hasEmail(email: text);
    if (userId == null) {
      Dialogs.failDialog(context: context);
      return;
    }
    // check if this user is already added
    if (workers.any((element) => element.id == userId)) return;
    // add to the cafe
    final worker = await Worker.create(userId: userId, shopId: widget.shop.id!);
    // check for the result
    if (worker == null) {
      Dialogs.failDialog(context: context);
      return;
    }
    // add to the list
    setState(() => workers.add(worker));
    Navigator.pop(context);
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('çalışan'),
        onPressed: () => Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage()),
        actions: [],
      ).build(context),
      floatingActionButton: FloatingActionButton(onPressed: addWorkerButton, child: const Icon(Icons.add_rounded)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SizedBox(
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
      bottomNavigationBar: AdminShopBottomNav(
        selectedIndex: 2,
        shop: widget.shop,
      ),
    );
  }
}
