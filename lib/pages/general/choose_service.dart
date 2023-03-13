import 'package:barbers/models/service.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/choose_service.dart';
import 'package:barbers/pages/general/select_schedule.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';

class ChooseServicePage extends StatefulWidget {
  final Worker barber;
  const ChooseServicePage({
    Key? key,
    required this.barber,
  }) : super(key: key);

  @override
  State<ChooseServicePage> createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  List<Service> selectedServices = [];
  List<Service> services = [];
  bool dataLoaded = false;

  @override
  initState() {
    Service.getShops(shopId: AppManager.shop.id!).then((value) {
      setState(() {
        services = value;
        dataLoaded = true;
      });
    });
    super.initState();
  }

  void selectService(Service service, bool isActive) {
    if (isActive) {
      selectedServices.add(service);
    } else {
      selectedServices.remove(service);
    }
  }

  void selectSchedule(BuildContext context) {
    if (selectedServices.isEmpty) return;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SelectSchedulePage(
          services: selectedServices,
          worker: widget.barber,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('hizmet'),
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
                  child: !dataLoaded
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount: services.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.65,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return ChooseServiceCard(
                              barber: widget.barber,
                              service: services[index],
                              select: selectService,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                height: 75,
                child: IconTextButton(
                  func: () => selectSchedule(context),
                  icon: Icons.timelapse,
                  text: "Select Schedule",
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
