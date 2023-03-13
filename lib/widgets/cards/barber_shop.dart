import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/general/barber_shop.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarberShopCard extends StatefulWidget {
  final BarberShop shop;
  const BarberShopCard({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberShopCard> createState() => _BarberShopCardState();
}

class _BarberShopCardState extends State<BarberShopCard> {
  Uint8List? imageData;

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
            color: Colorer.surface,
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
                      style: const TextStyle(
                        color: Colorer.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.shop.description!,
                      style: const TextStyle(
                        color: Colorer.onPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // bottom content
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.camera),
                            Text(
                              "@${widget.shop.instagram!}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "${widget.shop.starAverage!}",
                              style: const TextStyle(
                                color: Colorer.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "(${widget.shop.comments})",
                              style: const TextStyle(
                                color: Colorer.onPrimary,
                              ),
                            ),
                          ],
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
