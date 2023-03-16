import 'dart:io';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/pages/worker/edit_shop.dart';
import 'package:barbers/pages/worker/shops.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/nav_bars/worker_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkerShopPage extends StatefulWidget {
  final Worker worker;
  final BarberShop shop;
  const WorkerShopPage({
    Key? key,
    required this.shop,
    required this.worker,
  }) : super(key: key);

  @override
  State<WorkerShopPage> createState() => _WorkerShopPageState();
}

class _WorkerShopPageState extends State<WorkerShopPage> {
  Uint8List? imageData;
  late File imageFile;

  bool get isOpenVisual {
    if (widget.shop.isEmpty! && widget.shop.isOpen!) return true;
    return false;
  }

  @override
  initState() {
    imageData = widget.shop.getImage;
    super.initState();
  }

  backButton(BuildContext context) => Pusher.pushAndRemoveAll(context, const WorkerBarberShopsPage());

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
                    // top shadow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: const Alignment(0, -1),
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
                          end: const Alignment(0, 1),
                          colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black26],
                        ),
                      ),
                    ),
                    // top content
                    // return button
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colorer.surface,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => backButton(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colorer.onSurface,
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
                          decoration: const BoxDecoration(
                            color: Colorer.surface,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => Pusher.pushAndRemoveAll(
                                context,
                                WorkerShopEditPage(
                                  shop: widget.shop,
                                  worker: widget.worker,
                                )),
                            icon: const Icon(
                              Icons.edit_document,
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
                          "${isOpenVisual ? "OPEN" : "CLOSE"} NOW",
                          style: const TextStyle(color: Colorer.primary, fontWeight: FontWeight.w700),
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
                      style: const TextStyle(
                        color: Colorer.onBackground,
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.shop.description!,
                      style: const TextStyle(
                        color: Colorer.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Adres: ${widget.shop.location!}",
                      style: const TextStyle(
                        color: Colorer.onPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Tel no: ${widget.shop.phone!}",
                      style: const TextStyle(
                        color: Colorer.onPrimary,
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
      bottomNavigationBar: WorkerShopBottomNav(
        selectedIndex: 0,
        shop: widget.shop,
        worker: widget.worker,
      ),
    );
  }
}
