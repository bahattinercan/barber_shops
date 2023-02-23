import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/utils/validator_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:barbers/widgets/text_form_fields/base.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBarberShopPage extends StatefulWidget {
  const CreateBarberShopPage({Key? key}) : super(key: key);

  @override
  State<CreateBarberShopPage> createState() => _CreateBarberShopPageState();
}

class _CreateBarberShopPageState extends State<CreateBarberShopPage> {
  Uint8List? imageMemoryData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _insta = TextEditingController();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? base64Image;

  void changeImage() {
    pickImage();
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File imageFile = File(image.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    base64Image = base64Encode(imageBytes);
    setState(() {
      imageMemoryData = base64Decode(base64Image!);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      Dialogs.failDialog(context: context, content: "Bilgileri eksiksiz doldurun");
      return;
    }
    if (countryValue == null || stateValue == null || cityValue == null) {
      Dialogs.failDialog(context: context, content: "Adres bilgilerinizi kontrol edin");
      return;
    }
    if (base64Image == null) {
      Dialogs.failDialog(context: context, content: "Resim ekleyin");
      return;
    }

    await HttpReqManager.postReq(
        "/barber_shops",
        barberShopToJson(BarberShop(
          name: _name.text,
          description: _desc.text,
          location: _address.text,
          phone: _phone.text,
          bossId: AppManager.user.id,
          instagram: _insta.text,
          country: countryValue,
          province: stateValue,
          district: cityValue,
          profilePicture: base64Image,
        )));

    if (HttpReqManager.resultNotifier.value is RequestLoadFailure) {
      Dialogs.failDialog(context: context);
      return;
    }
    PushManager.pushAndRemoveAll(context, AdminBarberShopsPage());
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('oluştur'),
        onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberShopsPage()),
      ).build(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: (imageMemoryData == null)
                              ? Image.asset(
                                  "assets/images/image_not_found.jpg",
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(
                                  imageMemoryData!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        GestureDetector(
                          onTap: changeImage,
                          child: Container(
                            alignment: Alignment(.9, -.9),
                            child: Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BaseTextFormField(
                    controller: _name,
                    labelText: "isim",
                    maxLength: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _desc,
                    labelText: "açıklama",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _address,
                    labelText: "adres",
                    icon: Icons.location_on,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _phone,
                    labelText: "telefon",
                    hintText: "5xx xxx xx xx",
                    maxLength: 10,
                    icon: Icons.phone_rounded,
                    validator: ValidatorManager.phoneValidator,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _insta,
                    labelText: "instagram",
                    icon: Icons.camera,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SelectState(
                    onCountryChanged: (value) {
                      if (value == "Ülke Seç")
                        countryValue = null;
                      else
                        countryValue = value;
                    },
                    onStateChanged: (value) {
                      if (value == "Şehir Seç")
                        stateValue = null;
                      else
                        stateValue = value;
                    },
                    onCityChanged: (value) {
                      if (value == "İlçe Seç")
                        cityValue = null;
                      else
                        cityValue = value;
                    },
                  ),
                  BaseButton(
                    text: "Gönder",
                    onPressed: _submit,
                  ),
                  SizedBox(
                    height: 10,
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
