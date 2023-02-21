import 'dart:convert';
import 'dart:io';

import 'package:barbers/models/service.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/main_colors.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
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
  Uint8List? imageData = null;
  late File imageFile;
  @override
  initState() {
    super.initState();
  }

  updateItem(Service service) {
    widget.service = service;
  }

  delete(int id) async {
    final request = await HttpReqManager.deleteReq("/services/${id}");
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
      bool result = await HttpReqManager.putReq(
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
      print(e);
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
    try {
      if (!formKey.currentState!.validate()) return;
      final moneyString = text.replaceAll("₺", "");
      bool result = await HttpReqManager.putReq(
        "/services/data/${widget.service.id}/price",
        jsonEncode({"data": moneyString}),
      );
      if (result) {
        setState(() => widget.service.price = moneyString);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.design_services,
                        color: MainColors.triadic_1,
                      ),
                    ),
                    title: Text(
                      widget.service.name!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      widget.service.price! + " ₺",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: PopupMenuButton(itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(value: 1, child: Text("İsim düzenle")),
                        const PopupMenuItem<int>(value: 2, child: Text("Fiyat düzenle")),
                        const PopupMenuItem<int>(value: 99, child: Text("Sil")),
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
