import 'package:barbers/models/service_static.dart';
import 'package:barbers/models/work_time_static.dart';

class AppController {
  static final instance = AppController._internal();
  AppController._internal();

  //#region lists
  List<ServiceStatic> services = [
    ServiceStatic(name: "Clipper Cut", price: 55),
    ServiceStatic(name: "Signature Cut", price: 75),
    ServiceStatic(name: "Haircut & Shave", price: 90),
    ServiceStatic(name: "Beard Trim", price: 30),
    ServiceStatic(name: "Kid's Haircut", price: 20),
    ServiceStatic(name: "Hair Color", price: 35),
    ServiceStatic(name: "Manicure", price: 30),
    ServiceStatic(name: "Deep Tissue", price: 40),
    ServiceStatic(name: "Hot Stone", price: 105),
    ServiceStatic(name: "Salt Glow", price: 100),
  ];

  List<WorkTimeStatic> workTimes = [
    WorkTimeStatic(available: true, hour: 7, minute: 00),
    WorkTimeStatic(available: false, hour: 7, minute: 30),
    WorkTimeStatic(available: true, hour: 8, minute: 00),
    WorkTimeStatic(available: true, hour: 8, minute: 30),
    WorkTimeStatic(available: true, hour: 9, minute: 00),
    WorkTimeStatic(available: true, hour: 9, minute: 30),
    WorkTimeStatic(available: true, hour: 10, minute: 00),
    WorkTimeStatic(available: true, hour: 10, minute: 30),
    WorkTimeStatic(available: true, hour: 11, minute: 00),
    WorkTimeStatic(available: true, hour: 11, minute: 30),
    WorkTimeStatic(available: true, hour: 12, minute: 00),
    WorkTimeStatic(available: true, hour: 12, minute: 30),
    WorkTimeStatic(available: true, hour: 13, minute: 00),
    WorkTimeStatic(available: true, hour: 13, minute: 30),
    WorkTimeStatic(available: true, hour: 14, minute: 00),
    WorkTimeStatic(available: true, hour: 14, minute: 30),
    WorkTimeStatic(available: true, hour: 15, minute: 00),
    WorkTimeStatic(available: true, hour: 15, minute: 30),
    WorkTimeStatic(available: true, hour: 16, minute: 00),
    WorkTimeStatic(available: true, hour: 16, minute: 30),
    WorkTimeStatic(available: true, hour: 17, minute: 00),
    WorkTimeStatic(available: true, hour: 17, minute: 30),
    WorkTimeStatic(available: true, hour: 18, minute: 00),
    WorkTimeStatic(available: true, hour: 18, minute: 30),
    WorkTimeStatic(available: true, hour: 19, minute: 00),
    WorkTimeStatic(available: true, hour: 19, minute: 30),
    WorkTimeStatic(available: true, hour: 20, minute: 00),
    WorkTimeStatic(available: true, hour: 20, minute: 30),
    WorkTimeStatic(available: true, hour: 21, minute: 00),
    WorkTimeStatic(available: true, hour: 21, minute: 30),
    WorkTimeStatic(available: true, hour: 22, minute: 00),
    WorkTimeStatic(available: true, hour: 22, minute: 30),
    WorkTimeStatic(available: true, hour: 23, minute: 00),
    WorkTimeStatic(available: true, hour: 23, minute: 30),
  ];
  //#endregion
}
