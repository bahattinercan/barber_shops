import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/barber_appointments.dart';
import 'package:barbers/pages/admin/services.dart';
import 'package:barbers/pages/admin/workers.dart';
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
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      onTap: (value) => onTap(value, context),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Dükkan"),
        BottomNavigationBarItem(icon: Icon(Icons.design_services), label: "Hizmetler"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Çalışanlar"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Randevular"),
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
        PushManager.pushReplacement(context, AdminServicesPage(shop: widget.shop));
        break;
      case 2:
        PushManager.pushReplacement(
            context,
            AdminWorkersPage(
              shop: widget.shop,
              canRemoveWorker: true,
            ));
        break;
      case 3:
        PushManager.pushReplacement(context, AdminBarberAppointmentsPage(shop: widget.shop));
        break;
      default:
    }
  }
}
