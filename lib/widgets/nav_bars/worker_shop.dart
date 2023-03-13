import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/worker/appointments.dart';
import 'package:barbers/pages/worker/shop.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:flutter/material.dart';

class WorkerShopBottomNav extends StatefulWidget {
  final Worker worker;
  final BarberShop shop;
  final int selectedIndex;
  const WorkerShopBottomNav({
    super.key,
    required this.selectedIndex,
    required this.shop,
    required this.worker,
  });

  @override
  State<WorkerShopBottomNav> createState() => _WorkerShopBottomNavState();
}

class _WorkerShopBottomNavState extends State<WorkerShopBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (value) => onTap(value, context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Kafe"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Randevular"),
      ],
    );
  }

  void onTap(int value, context) {
    if (widget.selectedIndex == value) return;
    switch (value) {
      case 0:
        Pusher.pushReplacement(context, WorkerShopPage(shop: widget.shop, worker: widget.worker));
        break;
      case 1:
        Pusher.pushReplacement(context, WorkerAppointmentsPage(shop: widget.shop, worker: widget.worker));
        break;
      default:
    }
  }
}
