import 'package:barbers/widgets/cards/choose_barber.dart';
import 'package:barbers/models/barber_static.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

class ChooseBarberPage extends StatefulWidget {
  ChooseBarberPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseBarberPage> createState() => _ChooseBarberPageState();
}

class _ChooseBarberPageState extends State<ChooseBarberPage> {
  List<BarberStatic> barbers = [
    BarberStatic(name: "Osman", availableTime: DateTime.now()),
    BarberStatic(name: "Deniz", availableTime: DateTime.now().add(Duration(hours: 5, minutes: 1))),
    BarberStatic(name: "Gökhan", availableTime: DateTime.now()),
    BarberStatic(name: "Mehmet", availableTime: DateTime.now()),
    BarberStatic(name: "Furkan", availableTime: DateTime.now()),
    BarberStatic(name: "İsmail", availableTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                                child: Icon(Icons.close),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 7,
                  child: Text(
                    "Choose your barber",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                ),
                Expanded(
                  flex: 83,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: GridView.builder(
                      itemCount: barbers.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .9,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, _) {
                        int index = _ - 1;
                        if (index == -1)
                          return ChooseBarberCard(isAny: true);
                        else
                          return ChooseBarberCard(
                            barber: barbers[index],
                          );
                      },
                    ),
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
