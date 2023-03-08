// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:barbers/models/appointment.dart';
import 'package:barbers/models/selectable_day.dart';
import 'package:barbers/models/service.dart';
import 'package:barbers/models/work_time.dart';
import 'package:barbers/models/work_time_static.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/general/home.dart';
import 'package:barbers/panels/select_schedule/select_day_list.dart';
import 'package:barbers/panels/select_schedule/select_time_grid.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/formatter.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectSchedulePage extends StatefulWidget {
  final Worker worker;
  final List<Service> services;

  const SelectSchedulePage({Key? key, required this.services, required this.worker}) : super(key: key);

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  final DateTime _now = DateTime.now();
  final List<SelectableDay> _dates = [];
  bool dataLoaded = false;
  DateTime? _selectedDateTime;
  double _totalCost = 0;
  bool _canSelectTime = false;
  bool _canBook = false;
  WorkTime? _workTime;

  final List<WorkTimeStatic> _workTimes = AppManager.instance.workTimes;
  List<WorkTimeStatic> _availableTimes = [];
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late TimeOfDay breakStart;
  late TimeOfDay breakEnd;

  @override
  void initState() {
    setup();
    super.initState();
  }

  void setup() {
    WorkTime.getBarber(
      workerId: widget.worker.id!,
      shopId: AppManager.shop.id!,
    ).then((workTime) {
      if (workTime == null) {
        Dialogs.failDialog(
          context: context,
          content: "Şu anda bu berber'den randevu alamazsınız!",
          okFunction: () => Navigator.pop(context),
        );
        return;
      }
      for (var i = 0; i < 31; i++) {
        DateTime dateTime = _now.add(Duration(days: i));
        bool isActive = false;

        String day = Formatter.dayName.format(dateTime).toLowerCase();
        switch (day) {
          case "monday":
            if (workTime.monday!) isActive = true;
            break;
          case "tuesday":
            if (workTime.tuesday!) isActive = true;
            break;
          case "wednesday":
            if (workTime.wednesday!) isActive = true;
            break;
          case "thursday":
            if (workTime.thursday!) isActive = true;
            break;
          case "friday":
            if (workTime.friday!) isActive = true;
            break;
          case "saturday":
            if (workTime.saturday!) isActive = true;
            break;
          case "sunday":
            if (workTime.sunday!) isActive = true;
            break;
          default:
        }
        // gün için eğer o gün tatil değilse

        setState(() {
          _dates.add(SelectableDay(dateTime: dateTime, isActive: isActive));
        });
      }
      // toplam fiyat
      for (var i = 0; i < widget.services.length; i++) {
        _totalCost += double.parse(widget.services[i].price!);
      }
      setState(() {
        _workTime = workTime;
        dataLoaded = true;
      });
    });
  }

  Future<void> setupTimeGrid() async {
    setState(() {
      _availableTimes = [];
    });

    if (_selectedDateTime == null || _workTime == null) return;
    DateTime dayStart = _selectedDateTime!;
    DateTime dayEnd = _selectedDateTime!.add(const Duration(
      hours: 23,
      minutes: 59,
    ));

    final takenTimes = await Appointment.getTakenTimes(
      shopId: AppManager.shop.id!,
      workerId: widget.worker.id!,
      startTime: dayStart,
      endTime: dayEnd,
    );

    startTime = _workTime!.startTimeOfDay!;
    endTime = _workTime!.endTimeOfDay!;
    breakStart = _workTime!.breakStartTimeOfDay!;
    breakEnd = _workTime!.breakEndTimeOfDay!;
    for (var i = 0; i < _workTimes.length; i++) {
      WorkTimeStatic workTime = _workTimes[i];
      DateTime workDateTime = _selectedDateTime!.add(Duration(hours: workTime.hour, minutes: workTime.minute));

      // şu anki saatten sonraysa
      bool lateFromNow = _now.compareTo(workDateTime) == -1;

      // başlangıç saatinden sonraysa
      bool lateFromStart =
          workTime.hour > startTime.hour || (workTime.hour == startTime.hour && workTime.minute >= startTime.minute);
      // bitiş saatinden önceyse
      bool earlyFromEnd =
          workTime.hour < endTime.hour || (workTime.hour == endTime.hour && workTime.minute <= endTime.minute);
      // molada değilse
      bool notInBreak = (workTime.hour < breakStart.hour ||
              (workTime.hour == breakStart.hour && workTime.minute <= breakStart.minute)) ||
          (workTime.hour > breakEnd.hour || (workTime.hour == breakEnd.hour && workTime.minute >= breakEnd.minute));

      workTime.available = true;
      if (!lateFromNow) {
        workTime.available = false;
      } else {
        // eğer randevu alınmamışsa randevu alınabilsin
        for (var i = 0; i < takenTimes.length; i++) {
          if (takenTimes[i].time!.compareTo(workDateTime) == 0) {
            workTime.available = false;
          }
        }
      }

      if (lateFromStart && earlyFromEnd && notInBreak && workTime.available) {
        // add to the list
        setState(() {
          _availableTimes.add(workTime);
        });
      }
    }
  }

  void selectDay(DateTime dateTime) {
    setState(() {
      _canSelectTime = true;
      _selectedDateTime = dateTime.subtract(Duration(
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        milliseconds: dateTime.millisecond,
        microseconds: dateTime.microsecond,
      ));
    });
    setupTimeGrid();
  }

  void selectTime(int hour, int minute) {
    _selectedDateTime = _selectedDateTime!.subtract(Duration(
      hours: _selectedDateTime!.hour,
      minutes: _selectedDateTime!.minute,
    ));
    setState(() {
      _canBook = true;
      _selectedDateTime = _selectedDateTime!.add(Duration(hours: hour, minutes: minute));
    });
  }

  Future<void> bookNow() async {
    final List<int> serviceIds = widget.services.map((service) => service.id!).toList();
    await Requester.postReq(
      "/appointments",
      appointmentToJson(
        Appointment(
          price: "$_totalCost",
          userId: AppManager.user.id,
          barberShopId: AppManager.shop.id,
          services: serviceIds,
          time: _selectedDateTime,
          workerId: widget.worker.id,
          workerUid: widget.worker.userId,
        ),
      ),
    );
    if (Requester.notifier.value is RequestLoadSuccess) {
      Pusher.pushAndRemoveAll(context, const HomePage());
      Dialogs.successDialog(context: context);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('Randevu'),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: !dataLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            DateFormat('MMMM yyyy').format(_now).toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colorer.primaryVariant,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 70,
                          child: SelectDayList(
                            days: _dates,
                            select: selectDay,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: _canSelectTime,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _selectedDateTime == null
                                  ? ""
                                  : DateFormat('EEEE, MMMM yy').format(_selectedDateTime!).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colorer.primaryVariant,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Visibility(
                            visible: _canSelectTime,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SelectTimeGrid(
                                select: selectTime,
                                workTime: _workTime!,
                                dateTime: _selectedDateTime,
                                workerId: widget.worker.id!,
                                availableTimes: _availableTimes,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Visibility(
                      visible: _canBook,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colorer.surface,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "${AppManager.shop.name!} Barbershop",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colorer.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12.5),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.asset(
                                              "assets/icons/barber_shop.jpg",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                widget.worker.fullname!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Colorer.primaryVariant,
                                                ),
                                              ),
                                              Text(
                                                widget.services[0].name! +
                                                    (widget.services.length > 1
                                                        ? " +${widget.services.length - 1}"
                                                        : ""),
                                                style: const TextStyle(
                                                  color: Colorer.onSurface,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                _selectedDateTime == null
                                                    ? ""
                                                    : DateFormat("MMM dd'th' 'at' HH:mm", "en_US")
                                                        .format(_selectedDateTime!)
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colorer.onSurface,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "₺${_totalCost.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colorer.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12.5),
                                IconTextButton(
                                  func: bookNow,
                                  icon: Icons.timelapse,
                                  text: "Select Schedule",
                                  borderRadius: BorderRadius.circular(16),
                                  height: 45,
                                  backgroundColor: Colorer.secondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
      ),
    );
  }
}
