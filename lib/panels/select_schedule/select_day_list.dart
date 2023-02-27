import 'package:barbers/models/selectable_day.dart';
import 'package:barbers/widgets/cards/select_day.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectDayList extends StatefulWidget {
  List<SelectableDay> days;
  void Function(DateTime dateTime) select;

  SelectDayList({
    Key? key,
    required this.days,
    required this.select,
  }) : super(key: key);

  @override
  State<SelectDayList> createState() => _SelectDayListState();
}

class _SelectDayListState extends State<SelectDayList> {
  int _selectedIndex = -1;

  select(int index, DateTime dateTime) {
    setState(() {
      _selectedIndex = index;
    });
    widget.select(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: widget.days.length,
      itemBuilder: (context, index) {
        return SelectDayItem(
          selectableDay: widget.days[index],
          index: index,
          selectedIndex: _selectedIndex,
          select: select,
        );
      },
    );
  }
}
