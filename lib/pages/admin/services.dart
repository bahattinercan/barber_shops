import 'dart:async';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/service.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/bottom_sheets/text_field_2.dart';
import 'package:barbers/widgets/cards/admin_service.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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
    try {
      final datas = await HttpReqManager.getReq('/services/barber_shop/${widget.shop.id}');
      return serviceListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
  }

  void addItemButton() {
    AppManager.bottomSheet(
      context,
      TextField2BS(
        submit: addItem,
        maxLength: 40,
        labelText: "isim",
        hintText: "saç kesim",
        maxLength2: 12,
        labelText2: "ücret",
        hintText2: "5.00₺",
        keyboardType2: TextInputType.number,
        icon2: Icons.money,
        inputFormatters2: [
          CurrencyInputFormatter(
            leadingSymbol: "₺",
            thousandSeparator: ThousandSeparator.None,
            useSymbolPadding: false,
          )
        ],
      ),
    );
  }

  addItem(GlobalKey<FormState> formKey, String text, String text2) async {
    try {
      if (!formKey.currentState!.validate()) return;

      final moneyString = text2.replaceAll("₺", "");
      final result = await HttpReqManager.postReq(
        "/services",
        serviceToJson(Service(
          name: text,
          price: moneyString,
          userId: AppManager.user.id,
          barberShopId: widget.shop.id,
        )),
      );

      if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
        Dialogs.failDialog(context: context);
        return;
      }

      Service newItem = serviceFromJson(result);
      addItemToList(newItem);
      Navigator.pop(context);
      Dialogs.successDialog(context: context);
    } catch (e) {
      print(e);
    }
  }

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
