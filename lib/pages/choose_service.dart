import 'package:barbers/widgets/cards/choose_service.dart';
import 'package:barbers/models/barber_static.dart';
import 'package:barbers/models/service_static.dart';
import 'package:barbers/pages/select_schedule.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:barbers/widgets/buttons/icon_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseServicePage extends StatelessWidget {
  BarberStatic? barber;
  ChooseServicePage({
    Key? key,
    required this.barber,
  }) : super(key: key);

  List<ServiceStatic> selectedServices = [];

  void selectService(ServiceStatic service, bool isActive) {
    if (isActive) {
      selectedServices.add(service);
    } else {
      selectedServices.remove(service);
    }
  }

  void selectSchedule(BuildContext context) {
    if (selectedServices.length == 0) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SelectSchedulePage(
          selectedServices: selectedServices,
          barber: barber,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: MainColors.backgroundColor, borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MainColors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
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
                    "Choose services",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                ),
                Expanded(
                  flex: 76,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      itemCount: AppController.instance.services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.65,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return ChooseServiceCard(
                          barber: barber,
                          service: AppController.instance.services[index],
                          selectServiceF: selectService,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: IconTextButton(
                    func: () => selectSchedule(context),
                    icon: Icons.timelapse,
                    text: "Select Schedule",
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
