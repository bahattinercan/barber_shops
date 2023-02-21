import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/barber_shop.dart';
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
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Şuanki konum",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "Royal Ln. Mesa, New Jersey",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: MainColors.secondary_mat.shade200,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.person_rounded),
                onPressed: () {
                  // Add your onPressed callback here
                },
              ),
            ),
          ),
        ],
      ),
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
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: _shops.length,
                  itemBuilder: (context, index) {
                    return BarberShopCard(
                      shop: _shops[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
