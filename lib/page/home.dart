import 'package:barbers/items/barber_card.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/util/main_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BarberShop> _shops = [
    BarberShop(
      name: "Demiroğlu",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShop(
      name: "İbrahim & Dostça",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: false,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShop(
      name: "Altın",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShop(
      name: "Birikim",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: false,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
    BarberShop(
      name: "Men",
      stars: 4.2,
      numberOfStars: 1500,
      distance: 1.2,
      isOpen: true,
      description: "If you happen to be in the North New Hyde Park are and you need to look like a rock star",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MainColors.primary_w500,
                      borderRadius: BorderRadius.circular(24),
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
                                  padding: const EdgeInsets.all(16.0),
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
                                    "Current location",
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
                              padding: const EdgeInsets.all(16.0),
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
                Expanded(
                  flex: 90,
                  child: ListView.builder(
                    itemCount: _shops.length,
                    itemBuilder: (context, index) {
                      return BarberCard(
                        shop: _shops[index],
                      );
                    },
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
