import 'package:barbers/enums/user.dart';
import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/barber_shop.dart';
import 'package:barbers/utils/dialog_widgets.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:flutter/material.dart';

enum ECafeCard {
  boss,
  worker,
}

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
    final request = await HttpReqManager.deleteReq("/barber_shops/${id}");
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
              elevation: 2.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    minLeadingWidth: 12,
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    leading: IconButton(
                      color: MainColors.similar_color,
                      onPressed: () {},
                      icon: Icon(Icons.bookmark),
                    ),
                    title: Text(
                      widget.shop.name!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: PopupMenuButton(itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(value: 1, child: Text("Düzenle")),
                        const PopupMenuItem<int>(value: 99, child: Text("Sil")),
                      ];
                    }, onSelected: (value) {
                      switch (value) {
                        case 1:
                          switch (widget.eUser) {
                            case EUser.boss:
                              PushManager.push(context, AdminBarberPage(shop: widget.shop));
                              break;
                            case EUser.worker:
                              // TODO İLERİDE YAP
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
                    }),
                    subtitle: Text(
                      widget.shop.location!,
                      style: TextStyle(color: Colors.black),
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
