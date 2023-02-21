import 'package:barbers/models/barber_shop_static.dart';
import 'package:barbers/pages/barber.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

class BarberShopCard extends StatefulWidget {
  final BarberShopStatic shop;
  BarberShopCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberShopCard> createState() => _BarberShopCardState();
}

class _BarberShopCardState extends State<BarberShopCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BarberShopPage(shop: widget.shop);
              },
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: MainColors.backgroundColor,
            borderRadius: BorderRadius.circular(24),
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
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.black.withAlpha(0), Colors.black54, Colors.black],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shop.name,
                      style: TextStyle(color: MainColors.white, fontSize: 28, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.shop.description,
                      style: TextStyle(color: MainColors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: MainColors.active,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.shop.stars}",
                          style: TextStyle(
                            color: MainColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "(${widget.shop.numberOfStars})",
                          style: TextStyle(
                            color: MainColors.white,
                          ),
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.route,
                          color: MainColors.active,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.shop.distance} km",
                          style: TextStyle(
                            color: MainColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
