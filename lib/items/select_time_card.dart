import 'package:barbers/util/app_controller.dart';
import 'package:barbers/util/main_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectTimeCard extends StatefulWidget {
  final int hour;
  final int minute;
  int index;
  int selectedIndex;
  bool available;
  Function(int index, int hour, int minute) selectF;

  SelectTimeCard({
    Key? key,
    required this.hour,
    required this.minute,
    required this.index,
    required this.selectedIndex,
    required this.selectF,
    required this.available,
  }) : super(key: key);

  @override
  State<SelectTimeCard> createState() => _SelectTimeCardState();
}

class _SelectTimeCardState extends State<SelectTimeCard> {
  late final hourText;
  late final minuteText;

  void select() {
    if (!widget.available) return;
    widget.selectF(widget.index, widget.hour, widget.minute);
  }

  @override
  void initState() {
    super.initState();
    hourText = AppController.instance.formatIntTo2Letter(widget.hour);
    minuteText = AppController.instance.formatIntTo2Letter(widget.minute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: select,
      child: Container(
        decoration: BoxDecoration(
          color: !widget.available
              ? MainColors.grey
              : widget.selectedIndex == widget.index
                  ? MainColors.active
                  : MainColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse,
              color: !widget.available
                  ? MainColors.light_grey
                  : widget.selectedIndex == widget.index
                      ? MainColors.black
                      : MainColors.active,
            ),
            Text(
              " $hourText.$minuteText",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: !widget.available ? MainColors.light_grey : MainColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
