// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/pages/admin/shops.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/pusher.dart';
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
  final TextEditingController _name = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _insta = TextEditingController();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? base64Image;

  void changeImage() {
    pickImage();
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);
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

    BarberShop? newShop = await BarberShop.create(
      name: _name.text,
      description: _desc.text,
      location: _address.text,
      phone: _phone.text,
      bossId: AppManager.user.id!,
      instagram: _insta.text,
      country: countryValue!,
      province: stateValue!,
      district: cityValue!,
      profilePictureBase64: base64Image!,
    );
    if (newShop == null) {
      Dialogs.failDialog(context: context);
      return;
    }
    Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage());
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('oluştur'),
        onPressed: () => Pusher.pushAndRemoveAll(context, const AdminBarberShopsPage()),
      ).build(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
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
                            alignment: const Alignment(.9, -.9),
                            child: const Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BaseTextFormField(
                    controller: _name,
                    labelText: "isim",
                    maxLength: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _desc,
                    labelText: "açıklama",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _address,
                    labelText: "adres",
                    icon: Icons.location_on,
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  BaseTextFormField(
                    controller: _insta,
                    labelText: "instagram",
                    icon: Icons.camera,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectState(
                    onCountryChanged: (value) {
                      if (value == "Ülke Seç") {
                        countryValue = null;
                      } else {
                        countryValue = value;
                      }
                    },
                    onStateChanged: (value) {
                      if (value == "Şehir Seç") {
                        stateValue = null;
                      } else {
                        stateValue = value;
                      }
                    },
                    onCityChanged: (value) {
                      if (value == "İlçe Seç") {
                        cityValue = null;
                      } else {
                        cityValue = value;
                      }
                    },
                  ),
                  BaseButton(
                    text: "Gönder",
                    onPressed: _submit,
                  ),
                  const SizedBox(
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
