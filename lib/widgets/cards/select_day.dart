import 'package:barbers/models/selectable_day.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/custom_formats.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectDayItem extends StatefulWidget {
  SelectableDay selectableDay;
  int selectedIndex;
  int index;
  Function(int index, DateTime day) select;

  SelectDayItem({
    Key? key,
    required this.selectableDay,
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
      child: AbsorbPointer(
        absorbing: !widget.selectableDay.isActive,
        child: GestureDetector(
          onTap: () => widget.select(widget.index, widget.selectableDay.dateTime),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: !widget.selectableDay.isActive
                        ? ColorManager.surface
                        : widget.selectedIndex == widget.index
                            ? ColorManager.secondary
                            : ColorManager.surface,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  widget.selectableDay.dateTime.day.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: !widget.selectableDay.isActive
                        ? ColorManager.secondary
                        : widget.selectedIndex == widget.index
                            ? ColorManager.onPrimary
                            : ColorManager.onBackground,
                  ),
                )),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CustomFormats.dayOfTheWeek(widget.selectableDay.dateTime),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: !widget.selectableDay.isActive
                          ? ColorManager.secondary
                          : widget.selectedIndex == widget.index
                              ? ColorManager.onPrimary
                              : ColorManager.onBackground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
