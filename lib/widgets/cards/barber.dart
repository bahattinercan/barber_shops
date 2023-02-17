import 'package:barbers/models/barber_shop_static.dart';
import 'package:barbers/pages/barber.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:flutter/material.dart';

class BarberCard extends StatefulWidget {
  final BarberShopStatic shop;
  BarberCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberCard> createState() => _BarberCardState();
}

class _BarberCardState extends State<BarberCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
            color: MainColors.primary_w500,
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black45],
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
                      style: TextStyle(color: MainColors.white, fontSize: 32, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Barbershop",
                      style: TextStyle(color: MainColors.white, fontSize: 32, fontWeight: FontWeight.w400),
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
