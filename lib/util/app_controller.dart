import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/service.dart';
import 'package:barbers/models/work_time.dart';
import 'package:intl/intl.dart';

class AppController {
  static final instance = AppController._internal();
  AppController._internal();

  late BarberShop barberShop;

  //#region lists
  List<Service> services = [
    Service(name: "Clipper Cut", price: 55),
    Service(name: "Signature Cut", price: 75),
    Service(name: "Haircut & Shave", price: 90),
    Service(name: "Beard Trim", price: 30),
    Service(name: "Kid's Haircut", price: 20),
    Service(name: "Hair Color", price: 35),
    Service(name: "Manicure", price: 30),
    Service(name: "Deep Tissue", price: 40),
    Service(name: "Hot Stone", price: 105),
    Service(name: "Salt Glow", price: 100),
  ];

  List<WorkTime> workTimes = [
    WorkTime(available: true, hour: 7, minute: 00),
    WorkTime(available: false, hour: 7, minute: 30),
    WorkTime(available: true, hour: 8, minute: 00),
    WorkTime(available: true, hour: 8, minute: 30),
    WorkTime(available: true, hour: 9, minute: 00),
    WorkTime(available: true, hour: 9, minute: 30),
    WorkTime(available: true, hour: 10, minute: 00),
    WorkTime(available: true, hour: 10, minute: 30),
    WorkTime(available: true, hour: 11, minute: 00),
    WorkTime(available: true, hour: 11, minute: 30),
    WorkTime(available: true, hour: 12, minute: 00),
    WorkTime(available: true, hour: 12, minute: 30),
    WorkTime(available: true, hour: 13, minute: 00),
    WorkTime(available: true, hour: 13, minute: 30),
    WorkTime(available: true, hour: 14, minute: 00),
    WorkTime(available: true, hour: 14, minute: 30),
    WorkTime(available: true, hour: 15, minute: 00),
    WorkTime(available: true, hour: 15, minute: 30),
    WorkTime(available: true, hour: 16, minute: 00),
    WorkTime(available: true, hour: 16, minute: 30),
    WorkTime(available: true, hour: 17, minute: 00),
    WorkTime(available: true, hour: 17, minute: 30),
    WorkTime(available: true, hour: 18, minute: 00),
    WorkTime(available: true, hour: 18, minute: 30),
    WorkTime(available: true, hour: 19, minute: 00),
    WorkTime(available: true, hour: 19, minute: 30),
    WorkTime(available: true, hour: 20, minute: 00),
    WorkTime(available: true, hour: 20, minute: 30),
    WorkTime(available: true, hour: 21, minute: 00),
    WorkTime(available: true, hour: 21, minute: 30),
    WorkTime(available: true, hour: 22, minute: 00),
    WorkTime(available: true, hour: 22, minute: 30),
    WorkTime(available: true, hour: 23, minute: 00),
    WorkTime(available: true, hour: 23, minute: 30),
  ];
  //#endregion

  DateFormat _weekOfTheDay = DateFormat('EEE');
  String formatDayOfTheWeek(DateTime dateTime) {
    return _weekOfTheDay.format(dateTime);
  }

  NumberFormat _IntTo2Letter = NumberFormat("00");
  String formatIntTo2Letter(int value) {
    return _IntTo2Letter.format(value);
  }
}
