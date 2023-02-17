import 'package:barbers/models/barber_static.dart';
import 'package:barbers/models/service_static.dart';
import 'package:barbers/util/main_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseServiceCard extends StatefulWidget {
  BarberStatic? barber;
  ServiceStatic service;
  Function selectServiceF;
  ChooseServiceCard({
    Key? key,
    this.barber,
    required this.service,
    required this.selectServiceF,
  }) : super(key: key);

  @override
  State<ChooseServiceCard> createState() => _ChooseServiceCardState();
}

class _ChooseServiceCardState extends State<ChooseServiceCard> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectServiceF(widget.service, !isActive);
        setState(() {
          isActive = !isActive;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? MainColors.active : MainColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.service.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 25,
                child: Divider(
                  thickness: 2,
                  // color: MainColors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                "₺" + widget.service.price.toStringAsFixed(2),
                style: TextStyle(
                  color: MainColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
