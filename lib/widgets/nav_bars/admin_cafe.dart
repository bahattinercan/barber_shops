import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/pages/admin/barber_shop.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminBarberShopBottomNB extends StatefulWidget {
  BarberShop shop;
  final int selectedIndex;
  AdminBarberShopBottomNB({
    super.key,
    required this.selectedIndex,
    required this.shop,
  });

  @override
  State<AdminBarberShopBottomNB> createState() => _AdminBarberShopBottomNBState();
}

class _AdminBarberShopBottomNBState extends State<AdminBarberShopBottomNB> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (value) => onTap(value, context),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Kafe"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menü"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Çalışanlar"),
      ],
    );
  }

  void onTap(int value, context) {
    if (widget.selectedIndex == value) return;
    switch (value) {
      case 0:
        PushManager.pushReplacement(
            context,
            AdminBarberPage(
              shop: widget.shop,
            ));
        break;
      case 1:
      //TODO YAP
      // PushManager.pushReplacement(context, AdminMenuItemsPage(cafe: widget.shop));
      // break;
      case 2:
        //TODO YAP
        // PushManager.pushReplacement(
        //     context,
        //     AdminWorkersPage(
        //       cafe: widget.shop,
        //       canRemoveWorker: true,
        //     ));
        break;
      default:
    }
  }
}
