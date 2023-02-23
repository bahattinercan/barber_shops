import 'dart:io';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shop_edit.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AdminBarberPage extends StatefulWidget {
  BarberShop shop;
  AdminBarberPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<AdminBarberPage> createState() => _AdminBarberPageState();
}

class _AdminBarberPageState extends State<AdminBarberPage> {
  Uint8List? imageData = null;
  late File imageFile;

  bool get isOpenVisual {
    if (widget.shop.isEmpty! && widget.shop.isOpen!) return true;
    return false;
  }

  @override
  initState() {
    imageData = widget.shop.getImage();
    super.initState();
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
                    color: ColorManager.surface,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: (widget.shop.profilePicture == null ||
                                widget.shop.profilePicture == "" ||
                                imageData == null)
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
                      // top shadow
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment(0, -1),
                            colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black26],
                          ),
                        ),
                      ),
                      // bottom shadow
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment(0, 1),
                            colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black26],
                          ),
                        ),
                      ),
                      // top content
                      // return button
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.surface,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberShopsPage()),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: ColorManager.onSurface,
                            ),
                          ),
                        ),
                      ),
                      // change shop detail  button
                      Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.surface,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => PushManager.pushAndRemoveAll(
                                  context,
                                  AdminShopEditPage(
                                    shop: widget.shop,
                                  )),
                              icon: Icon(
                                Icons.edit_document,
                                color: ColorManager.onSurface,
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
                            (isOpenVisual ? "OPEN" : "CLOSE") + " NOW",
                            style: TextStyle(color: ColorManager.primary, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      // bottom content
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.camera),
                                  Text(
                                    "@" + widget.shop.instagram!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${widget.shop.starAverage!}",
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
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shop.name!,
                        style: TextStyle(
                          color: ColorManager.onBackground,
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.shop.description!,
                        style: TextStyle(
                          color: ColorManager.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Adres: " + widget.shop.location!,
                        style: TextStyle(
                          color: ColorManager.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Tel no: " + widget.shop.phone!,
                        style: TextStyle(
                          color: ColorManager.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: AdminBarberShopBottomNB(selectedIndex: 0, shop: widget.shop),
    );
  }
}
