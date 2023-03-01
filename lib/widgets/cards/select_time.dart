import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/custom_formats.dart';
import 'package:flutter/material.dart';

class SelectTimeCard extends StatefulWidget {
  final int hour;
  final int minute;
  final int index;
  final int selectedIndex;
  final bool available;
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
    hourText = CustomFormats.intTo2Letter(widget.hour);
    minuteText = CustomFormats.intTo2Letter(widget.minute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: select,
      child: Container(
        decoration: BoxDecoration(
          color: !widget.available
              ? ColorManager.surface
              : widget.selectedIndex == widget.index
                  ? ColorManager.secondary
                  : ColorManager.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse,
              color: !widget.available
                  ? ColorManager.secondary
                  : widget.selectedIndex == widget.index
                      ? ColorManager.onPrimary
                      : ColorManager.onSurface,
            ),
            Text(
              " $hourText.$minuteText",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: !widget.available
                    ? ColorManager.secondary
                    : widget.selectedIndex == widget.index
                        ? ColorManager.onPrimary
                        : ColorManager.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
