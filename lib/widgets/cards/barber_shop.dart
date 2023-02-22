import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/barber_shop.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarberShopCard extends StatefulWidget {
  final BarberShop shop;
  BarberShopCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberShopCard> createState() => _BarberShopCardState();
}

class _BarberShopCardState extends State<BarberShopCard> {
  Uint8List? imageData = null;

  @override
  void initState() {
    imageData = widget.shop.getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          AppManager.shop = widget.shop;
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
            color: ColorManager.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: (widget.shop.profilePicture == null || widget.shop.profilePicture == "" || imageData == null)
                    ? Image.asset(
                        "assets/images/test.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        imageData!,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
              ),
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
                      widget.shop.name!,
                      style: TextStyle(
                        color: ColorManager.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.shop.description!,
                      style: TextStyle(
                        color: ColorManager.onPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${widget.shop.starAverage}",
                          style: TextStyle(
                            color: ColorManager.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          "(${widget.shop.comments})",
                          style: TextStyle(
                            color: ColorManager.onPrimary,
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
