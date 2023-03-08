import 'package:barbers/models/service.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseServiceCard extends StatefulWidget {
  Worker? barber;
  Service service;
  Function(Service service, bool isActive) selectServiceF;
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
          color: isActive == false ? Colorer.surface : Colorer.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.service.name!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: isActive == false ? Colorer.onBackground : Colorer.onPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 25,
                child: Divider(
                  thickness: 2,
                  color: isActive == false ? Colorer.primaryVariant : Colors.white54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                "₺" + double.parse(widget.service.price!).toStringAsFixed(2),
                style: TextStyle(
                  color: isActive == false ? Colorer.onBackground : Colorer.onPrimary,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
