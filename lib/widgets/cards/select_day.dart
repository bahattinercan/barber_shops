import 'package:barbers/utils/app_controller.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectDayItem extends StatefulWidget {
  DateTime datetime;
  int selectedIndex;
  int index;
  Function(int index, DateTime day) select;

  SelectDayItem({
    Key? key,
    required this.datetime,
    required this.selectedIndex,
    required this.index,
    required this.select,
  }) : super(key: key);

  @override
  State<SelectDayItem> createState() => _SelectDayItemState();
}

class _SelectDayItemState extends State<SelectDayItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => widget.select(widget.index, widget.datetime),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: widget.selectedIndex == widget.index ? MainColors.active : MainColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                widget.datetime.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              )),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppController.instance.formatDayOfTheWeek(widget.datetime),
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
