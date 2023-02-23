import 'package:barbers/widgets/cards/select_day.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectDayList extends StatefulWidget {
  List<DateTime> dates;
  void Function(DateTime dateTime) select;

  SelectDayList({
    Key? key,
    required this.dates,
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
      itemCount: widget.dates.length,
      itemBuilder: (context, index) {
        return SelectDayItem(
          datetime: widget.dates[index],
          index: index,
          selectedIndex: _selectedIndex,
          select: select,
        );
      },
    );
  }
}
