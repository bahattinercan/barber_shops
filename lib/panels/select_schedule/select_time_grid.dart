import 'package:barbers/widgets/cards/select_time.dart';
import 'package:barbers/models/work_time_static.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:flutter/material.dart';

class SelectTimeGrid extends StatefulWidget {
  final void Function(int hour, int minute) select;
  SelectTimeGrid({
    Key? key,
    required this.select,
  }) : super(key: key);

  @override
  State<SelectTimeGrid> createState() => _SelectTimeGridState();
}

class _SelectTimeGridState extends State<SelectTimeGrid> {
  int _selectedIndex = -1;

  select(int index, int hour, int minute) {
    setState(() {
      _selectedIndex = index;
    });
    widget.select(hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: AppController.instance.workTimes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.25,
      ),
      itemBuilder: (context, index) {
        WorkTimeStatic workTime = AppController.instance.workTimes[index];
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
