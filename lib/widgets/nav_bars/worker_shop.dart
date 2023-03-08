import 'package:barbers/models/barber_shop.dart';
import 'package:flutter/material.dart';

class WorkerCafeBottomNB extends StatefulWidget {
  final BarberShop shop;
  final int selectedIndex;
  const WorkerCafeBottomNB({
    super.key,
    required this.selectedIndex,
    required this.shop,
  });

  @override
  State<WorkerCafeBottomNB> createState() => _WorkerCafeBottomNBState();
}

class _WorkerCafeBottomNBState extends State<WorkerCafeBottomNB> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (value) => onTap(value, context),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Kafe"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menü"),
        // BottomNavigationBarItem(icon: Icon(Icons.people), label: "Çalışanlar"),
      ],
    );
  }

  void onTap(int value, context) {
    if (widget.selectedIndex == value) return;
    switch (value) {
      // TODO ADMİN WORKER PAGES
      // case 0:
      //   PushManager.pushReplacement(
      //       context,
      //       WorkerCafePage(
      //         cafe: widget.cafe,
      //       ));
      //   break;
      // case 1:
      //   PushManager.pushReplacement(context, WorkerMenuItemsPage(cafe: widget.cafe));
      //   break;
      // case 2:
      //   PushManager.pushReplacement(
      //       context,
      //       AdminWorkersPage(
      //         cafe: widget.cafe,
      //         canRemoveWorker: true,
      //       ));
      //   break;
      // default:
    }
  }
}
