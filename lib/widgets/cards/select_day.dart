import 'package:barbers/models/selectable_day.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/formatter.dart';
import 'package:flutter/material.dart';

class SelectDayItem extends StatefulWidget {
  final SelectableDay selectableDay;
  final int selectedIndex;
  final int index;
  final Function(int index, DateTime day) select;

  const SelectDayItem({
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
      padding: const EdgeInsets.only(right: 8),
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
                        ? Colorer.surface
                        : widget.selectedIndex == widget.index
                            ? Colorer.secondary
                            : Colorer.surface,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  widget.selectableDay.dateTime.day.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: !widget.selectableDay.isActive
                        ? Colorer.secondary
                        : widget.selectedIndex == widget.index
                            ? Colorer.onPrimary
                            : Colorer.onBackground,
                  ),
                )),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Formatter.dayOfTheWeek(widget.selectableDay.dateTime),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: !widget.selectableDay.isActive
                          ? Colorer.secondary
                          : widget.selectedIndex == widget.index
                              ? Colorer.onPrimary
                              : Colorer.onBackground,
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
