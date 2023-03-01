import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/requester.dart';
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

  @override
  initState() {
    getData.then((value) {
      setState(() {
        workers = value;
      });
    });
    super.initState();
  }

  Future<List<Worker>> get getData async {
    try {
      String datas = "";
      datas = await Requester.getReq('/workers/shop/${widget.shop.id}');

      return workerListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
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
                    child: GridView.builder(
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
