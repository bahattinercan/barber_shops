import 'dart:convert';
import 'dart:io';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/comments.dart';
import 'package:barbers/pages/admin/shop.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/buttons/row_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AdminShopEditPage extends StatefulWidget {
  BarberShop shop;
  AdminShopEditPage({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  State<AdminShopEditPage> createState() => _AdminShopEditPageState();
}

class _AdminShopEditPageState extends State<AdminShopEditPage> {
  late File imageFile;

  //#region Functions

  editNameButton() {
    AppManager.bottomSheet(context, TextFieldBS(submit: editName, maxLength: 60));
  }

  editName(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/name",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.shop.name = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  editDescriptionButton() {
    AppManager.bottomSheet(context, TextFieldBS(submit: editDescription));
  }

  editDescription(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/description",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.shop.description = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  editLocationButton() {
    AppManager.bottomSheet(context, TextFieldBS(submit: editLocation));
  }

  editLocation(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/location",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.shop.location = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  editPhoneButton() {
    AppManager.bottomSheet(
        context,
        TextFieldBS(
          submit: editPhone,
          maxLength: 20,
          keyboardType: TextInputType.phone,
        ));
  }

  editPhone(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/phone",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.shop.phone = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  editInstagramButton() {
    AppManager.bottomSheet(context, TextFieldBS(submit: editInstagram));
  }

  editInstagram(GlobalKey<FormState> formKey, String text) async {
    try {
      if (!formKey.currentState!.validate()) return;
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/instagram",
        jsonEncode({"data": text}),
      );
      if (result) {
        setState(() => widget.shop.instagram = text);
        Navigator.pop(context);
        Dialogs.successDialog(context: context);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> isOpen(bool? value) async {
    try {
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/is_open",
        jsonEncode({"data": value}),
      );
      if (result) {
        setState(() => widget.shop.isOpen = value);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> isEmpty(bool? value) async {
    try {
      bool result = await HttpReqManager.putReq(
        "/barber_shops/data/${widget.shop.id}/is_empty",
        jsonEncode({"data": value}),
      );
      if (result) {
        setState(() => widget.shop.isEmpty = value);
      } else {
        Dialogs.failDialog(context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  void changeImage() {
    pickImage();
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File imageFile = File(image.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    await HttpReqManager.postReq(
      "/barber_shops/set_image/${widget.shop.id}",
      jsonEncode({"image": base64Image}),
    );
    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Dialogs.failDialog(context: context);
      return;
    }

    setState(() {
      widget.shop.setImage(base64Image);
    });
  }

  changeLocation(String? countryValue, String? stateValue, String? cityValue) async {
    if (countryValue == null || stateValue == null || cityValue == null) return;
    await HttpReqManager.putReq(
        "barber_shops/change_location/${widget.shop.id}",
        barberShopToJson(BarberShop(
          country: countryValue,
          province: stateValue,
          district: cityValue,
        )));
    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Dialogs.failDialog(context: context);
      return;
    }
    Dialogs.successDialog(context: context);
    setState(() {
      widget.shop.country = countryValue;
      widget.shop.province = stateValue;
      widget.shop.district = cityValue;
    });
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle("Düzenle"),
        onPressed: () => PushManager.pushReplacement(context, AdminBarberPage(shop: widget.shop)),
      ).build(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              RowTextButton(
                text: "İsim değiştir",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: editNameButton,
              ),
              RowTextButton(
                text: "Açıklama ekle",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: editDescriptionButton,
              ),
              RowTextButton(
                text: "Konum Seç",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: editLocationButton,
              ),
              RowTextButton(
                text: "Tel No Değiştir",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: editPhoneButton,
              ),
              RowTextButton(
                text: "Instagram düzenle",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: editInstagramButton,
              ),
              RowTextButton(
                text: "Resim değiştir",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: changeImage,
              ),
              RowTextButton(
                text: "Dükkanı aç/kapa",
                iconData: Icons.circle,
                onPressed: () => isOpen(!widget.shop.isOpen!),
                iconColor: widget.shop.isOpen == false ? ColorManager.onSurface : ColorManager.surface,
              ),
              RowTextButton(
                text: "Dükkan boş/dolu",
                iconData: Icons.circle,
                onPressed: () => isEmpty(!widget.shop.isEmpty!),
                iconColor: widget.shop.isEmpty == false ? ColorManager.onSurface : ColorManager.surface,
              ),
              RowTextButton(
                text: "Yorumlar",
                iconData: Icons.arrow_forward_ios_rounded,
                onPressed: () => PushManager.push(context, AdminCommentsPage(shop: widget.shop)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
