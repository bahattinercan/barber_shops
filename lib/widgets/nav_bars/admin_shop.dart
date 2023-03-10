import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/appointments.dart';
import 'package:barbers/pages/admin/services.dart';
import 'package:barbers/pages/admin/workers.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/pages/admin/shop.dart';
import 'package:flutter/material.dart';

class AdminShopBottomNav extends StatefulWidget {
  final BarberShop shop;
  final int selectedIndex;
  const AdminShopBottomNav({
    super.key,
    required this.selectedIndex,
    required this.shop,
  });

  @override
  State<AdminShopBottomNav> createState() => _AdminShopBottomNavState();
}

class _AdminShopBottomNavState extends State<AdminShopBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      onTap: (value) => onTap(value, context),
      items: const [
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
        Pusher.pushReplacement(
            context,
            AdminShopPage(
              shop: widget.shop,
            ));
        break;
      case 1:
        Pusher.pushReplacement(context, AdminServicesPage(shop: widget.shop));
        break;
      case 2:
        Pusher.pushReplacement(
            context,
            AdminWorkersPage(
              shop: widget.shop,
              canRemoveWorker: true,
            ));
        break;
      case 3:
        Pusher.pushReplacement(context, AdminAppointmentsPage(shop: widget.shop));
        break;
      default:
    }
  }
}
