import 'package:barbers/models/barber_static.dart';
import 'package:barbers/pages/choose_service.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseBarberCard extends StatefulWidget {
  bool isAny;
  BarberStatic? barber;
  ChooseBarberCard({
    Key? key,
    this.isAny = false,
    this.barber,
  }) : super(key: key);

  @override
  State<ChooseBarberCard> createState() => _ChooseBarberCardState();
}

class _ChooseBarberCardState extends State<ChooseBarberCard> {
  String getAvailableTime() {
    DateTime now = DateTime.now();
    if (now.compareTo(widget.barber!.availableTime) == 1) {
      // past
      return "Available";
    } else if (now.compareTo(widget.barber!.availableTime) == -1) {
      // future
      return "Available \n" +
          "at " +
          widget.barber!.availableTime.hour.toString() +
          ":" +
          widget.barber!.availableTime.minute.toString();
    }
    return "Not Available";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ChooseServicePage(
            barber: widget.barber,
          );
        },
      )),
      child: Container(
        decoration: BoxDecoration(
          color: MainColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isAny
                ? Icon(
                    Icons.shuffle_rounded,
                    size: 72,
                    color: MainColors.active,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/icons/barber_shop.jpg",
                      fit: BoxFit.cover,
                      width: 72,
                      height: 72,
                    ),
                  ),
            SizedBox(height: 15),
            Text(
              widget.isAny ? "Any barber" : widget.barber!.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                widget.isAny ? "Will be selected base on service" : getAvailableTime(),
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
