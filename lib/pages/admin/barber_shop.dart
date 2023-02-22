import 'dart:convert';
import 'dart:io';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/barber_shops.dart';
import 'package:barbers/pages/admin/comments.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/color_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/bottom_sheets/change_location.dart';
import 'package:barbers/widgets/bottom_sheets/text_field.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:barbers/widgets/buttons/edit_text.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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

  //#region Functions

  @override
  initState() {
    imageData = widget.shop.getImage();
    super.initState();
  }

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
        Dialogs.successDialog(context: context);
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
        Dialogs.successDialog(context: context);
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
      imageData = base64Decode(base64Image);
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
      appBar: AppBar(
        title: Text(widget.shop.name!),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberShopsPage()),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: (widget.shop.profilePicture == null ||
                                widget.shop.profilePicture == "" ||
                                imageData == null)
                            ? Image.asset(
                                "assets/images/test.png",
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                imageData!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Container(
                        alignment: Alignment(.9, -.9),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.secondary,
                          ),
                          child: IconButton(
                            color: ColorManager.onSecondary,
                            onPressed: changeImage,
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                EditTextButton(
                  label: "İsim",
                  text: widget.shop.name!,
                  onTap: editNameButton,
                ),
                EditTextButton(
                  label: "Açıklama",
                  text: widget.shop.description == null ? "Yok" : widget.shop.description!,
                  onTap: editDescriptionButton,
                ),
                EditTextButton(
                  label: "Adres",
                  text: widget.shop.location == null ? "Yok" : widget.shop.location!,
                  onTap: editLocationButton,
                ),
                EditTextButton(
                  label: "Telefon",
                  text: widget.shop.phone == null ? "Yok" : widget.shop.phone!,
                  onTap: editPhoneButton,
                ),
                EditTextButton(
                  label: "Instagram",
                  text: widget.shop.instagram == null ? "Yok" : widget.shop.instagram!,
                  onTap: editInstagramButton,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Açık mı?",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      SizedBox(width: 2.5),
                      Checkbox(value: widget.shop.isOpen, onChanged: isOpen),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Boş mu?",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      SizedBox(width: 2.5),
                      Checkbox(value: widget.shop.isEmpty, onChanged: isEmpty),
                    ],
                  ),
                ),
                BaseButton(
                  text: "Konumu değiştir",
                  onPressed: () => AppManager.bottomSheet(context, ChangeLocationBS(submit: changeLocation)),
                ),
                BaseButton(
                  text: "Yorumlar",
                  onPressed: () => PushManager.push(context, AdminCommentsPage(shop: widget.shop)),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminBarberShopBottomNB(
        selectedIndex: 0,
        shop: widget.shop,
      ),
    );
  }
}
