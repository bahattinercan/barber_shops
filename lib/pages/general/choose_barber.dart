import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/choose_barber.dart';
import 'package:flutter/material.dart';

class ChooseBarberPage extends StatefulWidget {
  final BarberShop shop;
  ChooseBarberPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<ChooseBarberPage> createState() => _ChooseBarberPageState();
}

class _ChooseBarberPageState extends State<ChooseBarberPage> {
  List<Worker> workers = [];
  bool dataLoaded = false;

  @override
  initState() {
    Worker.getShops(shopId: widget.shop.id!).then((value) {
      setState(() {
        workers = value;
        dataLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('berber'),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: !dataLoaded
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            itemCount: workers.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .83,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return ChooseBarberCard(
                                worker: workers[index],
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
