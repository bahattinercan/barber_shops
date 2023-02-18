import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/barber.dart';
import 'package:barbers/models/barber_shop_static.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BarberShopStatic> _shops = [
    BarberShopStatic(
      name: "Demiroğlu",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShopStatic(
      name: "İbrahim & Dostça",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: false,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShopStatic(
      name: "Altın",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShopStatic(
      name: "Birikim",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: false,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShopStatic(
      name: "Men",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
  ];

  adminButton() {
    PushManager.pushAndRemoveAll(context, AdminBarberShopsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: adminButton,
        child: Icon(
          Icons.admin_panel_settings_rounded,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MainColors.primary_w500,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: MainColors.primary_w900,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.gps_fixed,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Şuanki konum",
                                    style: TextStyle(
                                      color: MainColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Royal Ln. Mesa, New Jersey",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MainColors.primary_w900,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 90,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: _shops.length,
                    itemBuilder: (context, index) {
                      return BarberCard(
                        shop: _shops[index],
                      );
                    },
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
