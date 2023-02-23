import 'package:barbers/models/service.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/home.dart';
import 'package:barbers/panels/select_schedule/select_day_list.dart';
import 'package:barbers/panels/select_schedule/select_time_grid.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectSchedulePage extends StatefulWidget {
  final Worker barber;
  final List<Service> services;

  SelectSchedulePage({Key? key, required this.services, required this.barber}) : super(key: key);

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  DateTime _now = DateTime.now();
  List<DateTime> _dates = [];
  DateTime? _selectedDateTime;
  double _totalCost = 0;
  bool _canSelectTime = false;
  bool _canBook = false;

  @override
  void initState() {
    _now == DateTime.now();
    for (var i = 0; i < 31; i++) {
      _dates.add(_now.add(Duration(days: i)));
    }
    for (var i = 0; i < widget.services.length; i++) {
      _totalCost += double.parse(widget.services[i].price!);
    }
    super.initState();
  }

  void selectDay(DateTime dateTime) {
    setState(() {
      _canSelectTime = true;
      _selectedDateTime = dateTime;
    });
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

  void bookNow() {
    print("BOOK NOW");

    PushManager.pushAndRemoveAll(context, HomePage());
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('Randevu'),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      DateFormat('MMMM yyyy').format(_now).toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: ColorManager.primaryVariant,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    child: SelectDayList(
                      dates: _dates,
                      select: selectDay,
                    ),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: _canSelectTime,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _selectedDateTime == null
                            ? ""
                            : DateFormat('EEEE, MMMM yy').format(_selectedDateTime!).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: ColorManager.primaryVariant,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Visibility(
                      visible: _canSelectTime,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SelectTimeGrid(select: selectTime),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Visibility(
                visible: _canBook,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            AppManager.shop.name! + " Barbershop",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: ColorManager.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.5),
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
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.barber.fullname!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: ColorManager.primaryVariant,
                                          ),
                                        ),
                                        Text(
                                          widget.services[0].name! +
                                              (widget.services.length > 1 ? " +${widget.services.length - 1}" : ""),
                                          style: TextStyle(
                                            color: ColorManager.onSurface,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          _selectedDateTime == null
                                              ? ""
                                              : DateFormat("MMM dd\'th\' \'at\' HH:mm", "en_US")
                                                  .format(_selectedDateTime!)
                                                  .toString(),
                                          style: TextStyle(
                                            color: ColorManager.onSurface,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "₺" + _totalCost.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorManager.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.5),
                          IconTextButton(
                            func: bookNow,
                            icon: Icons.timelapse,
                            text: "Select Schedule",
                            borderRadius: BorderRadius.circular(16),
                            height: 45,
                            backgroundColor: ColorManager.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
