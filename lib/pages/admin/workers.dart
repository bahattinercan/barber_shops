import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/user.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/cards/worker.dart';
import 'package:barbers/widgets/nav_bars/admin_cafe.dart';
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
  late Future<List<User>>? users;

  @override
  initState() {
    users = getUsers();
    super.initState();
  }

  updateCafe(BarberShop shop) {
    widget.shop = shop;
  }

  Future<List<User>>? getUsers() async {
    // TODO YAP
    // try {
    //   String datas = "";
    //   if (widget.shop.workers != null) {
    //     if (widget.shop.workers!.isEmpty) return [];
    //     datas = await HttpReqManager.postReq(
    //       '/users/with_ids',
    //       jsonEncode({"ids": List<dynamic>.from(widget.shop.workers!.map((x) => x))}),
    //     );
    //   } else {
    //     datas = await HttpReqManager.getReq('/users');
    //   }
    //   return userListFromJson(datas);
    // } catch (e) {
    //   print(e);
    //   return [];
    // }
    return [];
  }

  void RefreshUser(User user) {
    setState(() {
      user;
    });
  }

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
    // TODO add worker
    // try {
    //   if (!formKey.currentState!.validate()) return;
    //   // find user
    //   final workerRes = await HttpReqManager.getReq("/users/has_email/${text}");
    //   if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
    //     Dialogs.failDialog(context: context);
    //     return;
    //   }
    //   int workerId = jsonDecode(workerRes)["id"];
    //   // check if this user is already added
    //   if (widget.shop.workers!.contains(workerId)) return;

    //   // add to the cafe
    //   await HttpReqManager.putReq("/cafes/add_worker/${widget.shop.id}/${workerId}", null);
    //   // check for the result
    //   if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
    //     Dialogs.failDialog(context: context);
    //     return;
    //   }
    //   // update
    //   setState(() {
    //     widget.shop.workers!.add(workerId);
    //   });
    //   Navigator.pop(context);
    //   DialogManager.instance.successDialog(context: context);
    // } catch (e) {
    //   print(e);
    // }
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
        actions: [IconButton(onPressed: addWorkerButton, icon: Icon(Icons.add_rounded))],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          width: media.size.width,
          child: Column(children: [
            Expanded(
              child: FutureBuilder(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data == null
                        ? Container()
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return WorkerCard(
                                snapshot.data![index],
                                canRemoveWorker: widget.canRemoveWorker,
                                cafeId: widget.shop.id!,
                                removeWorker: (uid) {
                                  setState(() {
                                    // TODO REMOVE WORKER
                                    // widget.shop.workers!.remove(uid);
                                  });
                                },
                              );
                            },
                            itemCount: snapshot.data!.length,
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
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
