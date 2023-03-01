import 'package:barbers/models/work_time.dart';
import 'package:barbers/widgets/cards/select_time.dart';
import 'package:barbers/models/work_time_static.dart';
import 'package:flutter/material.dart';

class SelectTimeGrid extends StatefulWidget {
  final WorkTime workTime;
  final void Function(int hour, int minute) select;
  final DateTime? dateTime;
  final int workerId;
  final List<WorkTimeStatic> availableTimes;
  SelectTimeGrid({
    Key? key,
    required this.select,
    required this.workTime,
    required this.dateTime,
    required this.workerId,
    required this.availableTimes,
  }) : super(key: key);

  @override
  State<SelectTimeGrid> createState() => _SelectTimeGridState();
}

class _SelectTimeGridState extends State<SelectTimeGrid> {
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  select(int index, int hour, int minute) {
    setState(() {
      _selectedIndex = index;
    });
    widget.select(hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return widget.availableTimes == []
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            itemCount: widget.availableTimes.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.25,
            ),
            itemBuilder: (context, index) {
              WorkTimeStatic workTime = widget.availableTimes[index];

              return SelectTimeCard(
                hour: workTime.hour,
                minute: workTime.minute,
                index: index,
                selectedIndex: _selectedIndex,
                selectF: select,
                available: workTime.available,
              );
            },
          );
  }
}
