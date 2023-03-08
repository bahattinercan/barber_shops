import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/general/choose_barber.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarberShopPage extends StatefulWidget {
  final BarberShop shop;
  const BarberShopPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<BarberShopPage> createState() => _BarberShopPageState();
}

class _BarberShopPageState extends State<BarberShopPage> {
  Uint8List? imageData;

  @override
  void initState() {
    imageData = widget.shop.getImage();
    super.initState();
  }

  void selectBarberShop() {
    AppManager.shop = widget.shop;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChooseBarberPage(
        shop: widget.shop,
      );
    }));
  }

  bool get isOpen {
    if (widget.shop.isEmpty! && widget.shop.isOpen!) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Expanded(
              flex: 65,
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colorer.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:
                          (widget.shop.profilePicture == null || widget.shop.profilePicture == "" || imageData == null)
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
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: const Alignment(0, -0.5),
                          end: Alignment.topCenter,
                          colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black26],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colorer.surface,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colorer.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          "${isOpen ? "OPEN" : "CLOSE"} NOW",
                          style: const TextStyle(color: Colorer.primary, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 45,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: ColorManager.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shop.name!,
                        style: const TextStyle(
                          color: Colorer.onBackground,
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
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
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          widget.shop.description!,
                          style: const TextStyle(
                            color: Colorer.onPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "Adres: ${widget.shop.location!}",
                        style: const TextStyle(
                          color: Colorer.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colorer.primaryVariant,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: Icon(
                                    Icons.message,
                                    color: Colorer.onSecondary,
                                  ),
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
                                      color: Colorer.primaryVariant,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Colorer.onPrimary,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Book now",
                                            style: TextStyle(
                                              color: Colorer.onPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
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
          ]),
        ),
      ),
    );
  }
}
