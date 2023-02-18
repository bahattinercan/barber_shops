import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/service.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/admin_service.dart';
import 'package:barbers/widgets/nav_bars/admin_cafe.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminServicesPage extends StatefulWidget {
  BarberShop shop;
  AdminServicesPage({
    super.key,
    required this.shop,
  });

  @override
  State<AdminServicesPage> createState() => _AdminServicesPageState();
}

class _AdminServicesPageState extends State<AdminServicesPage> {
  late Future<List<Service>>? services;

  @override
  initState() {
    services = getData();
    super.initState();
  }

  Future<List<Service>>? getData() async {
    final datas = await HttpReqManager.getReq('/menu_items/cafe/${widget.shop.id}');
    return serviceListFromJson(datas);
  }

  void addItemButton() {
    // TODO
    // AppManager.bottomSheet(context, AddMenuItemBS(submit: addItem));
  }

  // TODO yap
  // addItem(GlobalKey<FormState> formKey, String name, EMenuItem menuItemType) async {
  //   try {
  //     if (!formKey.currentState!.validate()) return;
  //     final result = await HttpReqManager.postReq(
  //       "/menu_items",
  //       menuItemToJson(MenuItem(
  //         name: name,
  //         type: MenuItem.itemTypeToInt(menuItemType),
  //         cafeId: widget.cafe.id,
  //       )),
  //     );
  //     if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
  //       DialogManager.instance.failDialog(context: context);
  //       return;
  //     }
  //     MenuItem newItem = menuItemFromJson(result);
  //     addItemToList(newItem);
  //     Navigator.pop(context);
  //     DialogManager.instance.successDialog(context: context);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  addItemToList(Service service) async {
    (await services)!.add(service);
    setState(() {
      services;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name!),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberShopsPage()),
        ),
        actions: [IconButton(onPressed: addItemButton, icon: Icon(Icons.add_rounded))],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Expanded(
              child: FutureBuilder(
                future: services,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data == null
                        ? Container()
                        : ListView.builder(
                            itemBuilder: (context, index) => AdminServiceCard(snapshot.data![index]),
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
        selectedIndex: 1,
        shop: widget.shop,
      ),
    );
  }
}
