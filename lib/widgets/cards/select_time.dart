import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/formatter.dart';
import 'package:flutter/material.dart';

class SelectTimeCard extends StatefulWidget {
  final int hour;
  final int minute;
  final int index;
  final int selectedIndex;
  final bool available;
  final Function(int index, int hour, int minute) select;

  const SelectTimeCard({
    Key? key,
    required this.hour,
    required this.minute,
    required this.index,
    required this.selectedIndex,
    required this.select,
    required this.available,
  }) : super(key: key);

  @override
  State<SelectTimeCard> createState() => _SelectTimeCardState();
}

class _SelectTimeCardState extends State<SelectTimeCard> {
  late String hourText;
  late String minuteText;

  void select() {
    if (!widget.available) return;
    widget.select(widget.index, widget.hour, widget.minute);
  }

  @override
  void initState() {
    super.initState();
    hourText = Formatter.intTo2Letter(widget.hour);
    minuteText = Formatter.intTo2Letter(widget.minute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: select,
      child: Container(
        decoration: BoxDecoration(
          color: !widget.available
              ? Colorer.surface
              : widget.selectedIndex == widget.index
                  ? Colorer.secondary
                  : Colorer.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse,
              color: !widget.available
                  ? Colorer.secondary
                  : widget.selectedIndex == widget.index
                      ? Colorer.onPrimary
                      : Colorer.onSurface,
            ),
            Text(
              " $hourText.$minuteText",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: !widget.available
                    ? Colorer.secondary
                    : widget.selectedIndex == widget.index
                        ? Colorer.onPrimary
                        : Colorer.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
