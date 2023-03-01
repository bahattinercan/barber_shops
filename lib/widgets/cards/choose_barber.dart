import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/choose_service.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseBarberCard extends StatefulWidget {
  bool isAny;
  Worker worker;
  ChooseBarberCard({
    Key? key,
    this.isAny = false,
    required this.worker,
  }) : super(key: key);

  @override
  State<ChooseBarberCard> createState() => _ChooseBarberCardState();
}

class _ChooseBarberCardState extends State<ChooseBarberCard> {
  String getAvailableTime() {
    // ignore: unused_local_variable
    DateTime now = DateTime.now();
    // if (now.compareTo(widget.worker!.availableTime) == 1) {
    //   // past
    //   return "Available";
    // } else if (now.compareTo(widget.worker!.availableTime) == -1) {
    //   // future
    //   return "Available \n" +
    //       "at " +
    //       widget.worker!.availableTime.hour.toString() +
    //       ":" +
    //       widget.worker!.availableTime.minute.toString();
    // }
    return "Not Available";
  }

  onTap() {
    Pusher.push(context, ChooseServicePage(barber: widget.worker));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isAny
                ? Icon(
                    Icons.shuffle_rounded,
                    size: 100,
                    color: ColorManager.onSurface,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/icons/barber_shop.jpg",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
            SizedBox(height: 15),
            Text(
              widget.isAny ? "Any barber" : widget.worker.fullname!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: ColorManager.primaryVariant,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                widget.isAny ? "Will be selected base on service" : getAvailableTime(),
                style: TextStyle(
                  color: ColorManager.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
