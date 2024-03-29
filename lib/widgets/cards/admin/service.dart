// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:barbers/models/service.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/buttons/base_popup_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

// ignore: must_be_immutable
class AdminServiceCard extends StatefulWidget {
  Service service;

  AdminServiceCard(this.service, {super.key});

  @override
  State<AdminServiceCard> createState() => _AdminServiceCardState();
}

class _AdminServiceCardState extends State<AdminServiceCard> {
  bool isActive = true;
  Uint8List? imageData;
  late File imageFile;
  @override
  initState() {
    super.initState();
  }

  updateItem(Service service) {
    widget.service = service;
  }

  delete(int id) async {
    final request = await Service.delete(id: id);
    if (request) {
      setState(() => isActive = false);
      Dialogs.successDialog(context: context);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  deleteButton(int id) {
    Dialogs.yesNoDialog(context, "Ürün sil", "Ürün silinsin mi?", okF: () => delete(id));
  }

  void editNameButton() {
    AppManager.bottomSheet(
        context,
        TextFieldBS(
          submit: editName,
          maxLength: 60,
        ));
  }

  void editName(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await Requester.putReq(
        "/services/data/${widget.service.id}/name",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.service.name = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Dialogs.failDialog(context: context);
    }
  }

  void editPriceButton() {
    AppManager.bottomSheet(
        context,
        TextFieldBS(
          submit: editPrice,
          maxLength: 60,
          keyboardType: TextInputType.number,
          icon: Icons.money,
          inputFormatters: [
            CurrencyInputFormatter(
              leadingSymbol: "₺",
              thousandSeparator: ThousandSeparator.None,
              useSymbolPadding: false,
            )
          ],
        ));
  }

  void editPrice(GlobalKey<FormState> formKey, String text) async {
    if (!formKey.currentState!.validate()) return;
    final moneyString = text.replaceAll("₺", "");

    bool result = await Service.setData(id: widget.service.id!, column: "price", data: moneyString);
    if (result) {
      setState(() => widget.service.price = moneyString);
      Navigator.pop(context);
      Dialogs.successDialog(context: context);
    } else {
      Dialogs.failDialog(context: context);
    }
  }

  Future<Uint8List> getByteDataFromImage(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    List<int> byteList = data.buffer.asUint8List();
    return Uint8List.fromList(byteList);
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.design_services,
                        color: Colorer.primaryVariant,
                      ),
                    ),
                    title: Text(
                      widget.service.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colorer.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "${widget.service.price!} ₺",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colorer.onSurface,
                      ),
                    ),
                    trailing: BasePopupMenuButton(itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                            value: 1,
                            child: Text(
                              "İsim düzenle",
                              style: TextStyle(color: Colorer.onSurface),
                            )),
                        const PopupMenuItem<int>(
                            value: 2,
                            child: Text(
                              "Fiyat düzenle",
                              style: TextStyle(color: Colorer.onSurface),
                            )),
                        const PopupMenuItem<int>(
                            value: 99,
                            child: Text(
                              "Sil",
                              style: TextStyle(color: Colorer.onSurface),
                            )),
                      ];
                    }, onSelected: (value) {
                      switch (value) {
                        case 1:
                          editNameButton();
                          break;
                        case 2:
                          editPriceButton();
                          break;
                        case 99:
                          deleteButton(widget.service.id!);
                          break;
                        default:
                      }
                    }),
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
