import 'package:barbers/models/service.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/choose_service.dart';
import 'package:barbers/pages/select_schedule.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseServicePage extends StatefulWidget {
  Worker barber;
  ChooseServicePage({
    Key? key,
    required this.barber,
  }) : super(key: key);

  @override
  State<ChooseServicePage> createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  List<Service> selectedServices = [];

  List<Service> services = [];

  @override
  initState() {
    getData.then((value) {
      setState(() {
        services = value;
      });
    });
    super.initState();
  }

  Future<List<Service>> get getData async {
    try {
      String datas = "";
      datas = await HttpReqManager.getReq('/services/barber_shop/${AppController.instance.shop.id}');

      return serviceListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
  }

  void selectService(Service service, bool isActive) {
    if (isActive) {
      selectedServices.add(service);
    } else {
      selectedServices.remove(service);
    }
  }

  void selectSchedule(BuildContext context) {
    try {
      if (selectedServices.length == 0) {
        return;
      }
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SelectSchedulePage(
            services: selectedServices,
            barber: widget.barber,
          );
        },
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Hizmetler',
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GridView.builder(
                    itemCount: services.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.65,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ChooseServiceCard(
                        barber: widget.barber,
                        service: services[index],
                        selectServiceF: selectService,
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 75,
                child: IconTextButton(
                  func: () => selectSchedule(context),
                  icon: Icons.timelapse,
                  text: "Select Schedule",
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: ColorManager.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
