// ignore_for_file: use_build_context_synchronously

import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shop.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
import 'package:barbers/widgets/buttons/base_popup_menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminBarberShopCard extends StatefulWidget {
  EUser eUser;
  BarberShop shop;
  AdminBarberShopCard(this.shop, this.eUser, {super.key});

  @override
  State<AdminBarberShopCard> createState() => _AdminBarberShopCardState();
}

class _AdminBarberShopCardState extends State<AdminBarberShopCard> {
  bool isActive = true;

  updateCafe(BarberShop shop) {
    setState(() {
      widget.shop = shop;
    });
  }

  delete(int id) async {
    final request = await BarberShop.delete(id: id);
    if (request) {
      setState(() => isActive = false);
      Dialogs.successDialog(context: context);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  deleteButton(int id) {
    Dialogs.yesNoDialog(context, "Kafe'yi sil", "Kafe silinsin mi?", okF: () => delete(id));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isActive,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colorer.surface,
              elevation: 2.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    minLeadingWidth: 12,
                    horizontalTitleGap: 4,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    leading: IconButton(
                      color: Colorer.primaryVariant,
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark),
                    ),
                    title: Text(
                      widget.shop.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colorer.onSurface,
                      ),
                    ),
                    trailing: BasePopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem<int>(
                              value: 1,
                              child: Text(
                                "Düzenle",
                                style: TextStyle(color: Colorer.onSurface),
                              )),
                          const PopupMenuItem<int>(
                              value: 99,
                              child: Text(
                                "Sil",
                                style: TextStyle(color: Colorer.onSurface),
                              )),
                        ];
                      },
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            switch (widget.eUser) {
                              case EUser.boss:
                                Pusher.push(context, AdminBarberPage(shop: widget.shop));
                                break;
                              case EUser.worker:
                                // TODO ADMİN WORKER PAGE
                                //PushManager.push(context, WorkerCafePage(cafe: widget.shop));
                                break;
                              case EUser.normal:
                                break;
                              case EUser.admin:
                                break;
                            }
                            break;
                          case 99:
                            deleteButton(widget.shop.id!);
                            break;
                          default:
                        }
                      },
                    ),
                    subtitle: Text(
                      widget.shop.location!,
                      style: const TextStyle(
                        color: Colorer.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
