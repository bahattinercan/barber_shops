import 'package:barbers/panels/select_schedule/select_day_list.dart';
import 'package:barbers/panels/select_schedule/select_time_grid.dart';
import 'package:barbers/models/barber_static.dart';
import 'package:barbers/models/service_static.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectSchedulePage extends StatefulWidget {
  final BarberStatic? barber;
  final List<ServiceStatic> selectedServices;

  SelectSchedulePage({Key? key, required this.selectedServices, required this.barber}) : super(key: key);

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
    for (var i = 0; i < widget.selectedServices.length; i++) {
      _totalCost += widget.selectedServices[i].price;
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
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 75,
                child: Container(
                  decoration: BoxDecoration(color: MainColors.primary_w500, borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MainColors.primary_w900, borderRadius: BorderRadius.circular(100)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "Select your schedule",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 83,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                DateFormat('MMMM yyyy').format(_now).toString(),
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
                                child: Text(
                                  _selectedDateTime == null
                                      ? ""
                                      : DateFormat('EEEE, MMMM yy').format(_selectedDateTime!).toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: Visibility(
                                  visible: _canSelectTime,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: SelectTimeGrid(select: selectTime),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: Visibility(
                  visible: _canBook,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    decoration: BoxDecoration(color: MainColors.primary_w500, borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "ORDER AT: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: MainColors.light_grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppController.instance.barberShop.name + " Barbershop",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    children: [
                                      Text(
                                        widget.barber == null ? "Anyone" : widget.barber!.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        widget.selectedServices[0].name +
                                            (widget.selectedServices.length > 1
                                                ? " +${widget.selectedServices.length - 1}"
                                                : ""),
                                        style: TextStyle(
                                          color: MainColors.light_grey,
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
                                          color: MainColors.light_grey,
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
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.5),
                          Expanded(
                            child: IconTextButton(
                              func: bookNow,
                              icon: Icons.timelapse,
                              text: "Select Schedule",
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
