// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/service.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/bottom_sheets/text_field_2.dart';
import 'package:barbers/widgets/cards/admin/service.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:barbers/widgets/text_form_fields/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AdminServicesPage extends StatefulWidget {
  final BarberShop shop;
  const AdminServicesPage({
    super.key,
    required this.shop,
  });

  @override
  State<AdminServicesPage> createState() => _AdminServicesPageState();
}

class _AdminServicesPageState extends State<AdminServicesPage> {
  List<Service> services = [];
  List<Service> searchRes = [];
  bool dataLoaded = false;

  @override
  initState() {
    Service.getShops(shopId: widget.shop.id!).then((value) {
      setState(() {
        services = value;
        searchRes = value;
        dataLoaded = true;
      });
    });
    super.initState();
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
    if (!formKey.currentState!.validate()) return;

    final moneyString = text2.replaceAll("₺", "");

    Service? newService = await Service.create(
      name: text,
      price: moneyString,
      userId: AppManager.user.id!,
      shopId: widget.shop.id!,
    );
    if (newService == null) {
      Dialogs.failDialog(context: context);
      return;
    }
    addList(newService);
    Navigator.pop(context);
    Dialogs.successDialog(context: context);
  }

  addList(Service service) async {
    setState(() {
      services.add(service);
      searchRes.add(service);
    });
  }

  void onChanged(String value) {
    setState(() {
      searchRes = services.where((item) => item.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('hizmet'),
        onPressed: () => Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage()),
        actions: [IconButton(onPressed: addItemButton, icon: const Icon(Icons.add_rounded))],
      ).build(context),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SearchWidget(onChanged: onChanged),
              Expanded(
                child: !dataLoaded
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => AdminServiceCard(services[index]),
                        itemCount: services.length,
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AdminShopBottomNav(
        selectedIndex: 1,
        shop: widget.shop,
      ),
    );
  }
}
