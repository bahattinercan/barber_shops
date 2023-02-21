import 'package:barbers/models/barber_shop_static.dart';
import 'package:barbers/pages/choose_barber.dart';
import 'package:barbers/utils/app_controller.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

class BarberShopPage extends StatefulWidget {
  final BarberShopStatic shop;
  BarberShopPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberShopPage> createState() => _BarberShopPageState();
}

class _BarberShopPageState extends State<BarberShopPage> {
  void selectBarberShop() {
    AppController.instance.barberShop = widget.shop;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChooseBarberPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            child: Column(children: [
              Expanded(
                flex: 65,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: MainColors.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage("assets/icons/barber_shop.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment(0, -0.5),
                            end: Alignment.topCenter,
                            colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black26],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MainColors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            (widget.shop.isOpen ? "OPEN" : "CLOSE") + " NOW",
                            style: TextStyle(color: MainColors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MainColors.backgroundColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shop.name,
                            style: TextStyle(
                              color: MainColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            "Barbershop",
                            style: TextStyle(
                              color: MainColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.shop.description,
                            style: TextStyle(
                              color: MainColors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: MainColors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${widget.shop.stars}",
                                style: TextStyle(
                                  color: MainColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "(${widget.shop.numberOfStars})",
                                style: TextStyle(
                                  color: MainColors.grey,
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.route,
                                color: MainColors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${widget.shop.distance}",
                                style: TextStyle(
                                  color: MainColors.black,
                                ),
                              ),
                              Text(
                                " km",
                                style: TextStyle(
                                  color: MainColors.grey,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MainColors.secondary_mat.shade200,
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                      child: Icon(Icons.message),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: GestureDetector(
                                      onTap: selectBarberShop,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: MainColors.black, borderRadius: BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: MainColors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Book now",
                                                style: TextStyle(color: MainColors.white, fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
