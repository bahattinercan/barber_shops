import 'package:barbers/models/work_time.dart';
import 'package:barbers/widgets/cards/select_time.dart';
import 'package:barbers/models/work_time_static.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class SelectTimeGrid extends StatefulWidget {
  final WorkTime workTime;
  final void Function(int hour, int minute) select;
  SelectTimeGrid({
    Key? key,
    required this.select,
    required this.workTime,
  }) : super(key: key);

  @override
  State<SelectTimeGrid> createState() => _SelectTimeGridState();
}

class _SelectTimeGridState extends State<SelectTimeGrid> {
  int _selectedIndex = -1;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late TimeOfDay breakStart;
  late TimeOfDay breakEnd;

  @override
  void initState() {
    setState(() {
      startTime = widget.workTime.startTimeOfDay!;
      endTime = widget.workTime.endTimeOfDay!;
      breakStart = widget.workTime.breakStartTimeOfDay!;
      breakEnd = widget.workTime.breakEndTimeOfDay!;
    });

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
    return GridView.builder(
      itemCount: AppController.instance.workTimes.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.25,
      ),
      itemBuilder: (context, index) {
        WorkTimeStatic workTime = AppController.instance.workTimes[index];
        // saatler için
        // eğer zamanı start time'dan büyükse
        // ve end time'dan küçükse
        // ve break start ile break end'in arasında değilse
        // ve eşit değilse

        print("work time : ${workTime.hour}.${workTime.minute}");
        print("start time : ${startTime.hour}.${startTime.minute}");

        // başlangıç saatinden sonraysa
        bool lateFromStart =
            workTime.hour > startTime.hour || (workTime.hour == startTime.hour && workTime.minute >= startTime.minute);
        print("late from start : $lateFromStart");
        // bitiş saatinden önceyse
        bool earlyFromEnd =
            workTime.hour < endTime.hour || (workTime.hour == endTime.hour && workTime.minute <= endTime.minute);
        print("early from end : $earlyFromEnd");
        // molada değilse
        bool notInBreak = (workTime.hour < breakStart.hour ||
                (workTime.hour == breakStart.hour && workTime.minute <= breakStart.minute)) ||
            (workTime.hour > breakEnd.hour || (workTime.hour == breakEnd.hour && workTime.minute >= breakEnd.minute));
        print("not in the break : $notInBreak");
        // eğer randevu alınmamışsa
        // TODO eğer randevu alınmamışsa randevu alınabilsin
        bool isAvailable = true;

        print((lateFromStart && earlyFromEnd && notInBreak && isAvailable));
        if (lateFromStart && earlyFromEnd && notInBreak && isAvailable) {
          return SelectTimeCard(
            hour: workTime.hour,
            minute: workTime.minute,
            index: index,
            selectedIndex: _selectedIndex,
            selectF: select,
            available: workTime.available,
          );
        } else {
          print("domates");

          return null;
        }
      },
    );
  }
}
