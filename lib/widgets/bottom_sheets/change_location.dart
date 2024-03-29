import 'package:barbers/utils/colorer.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class ChangeLocationBS extends StatefulWidget {
  final void Function(
    String? countryValue,
    String? stateValue,
    String? cityValue,
  ) submit;
  const ChangeLocationBS({
    Key? key,
    required this.submit,
  }) : super(key: key);

  @override
  State<ChangeLocationBS> createState() => _ChangeLocationBSState();
}

class _ChangeLocationBSState extends State<ChangeLocationBS> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectState(
              onCountryChanged: (value) {
                if (value == "Ülke Seç" || value.isEmpty) {
                  countryValue = null;
                } else {
                  countryValue = value;
                }
              },
              onStateChanged: (value) {
                if (value == "Şehir Seç" || value.isEmpty) {
                  stateValue = null;
                } else {
                  stateValue = value;
                }
              },
              onCityChanged: (value) {
                if (value == "İlçe Seç" || value.isEmpty) {
                  cityValue = null;
                } else {
                  cityValue = value;
                }
              },
              dropdownColor: Colorer.surface,
              iconColor: Colorer.onBackground,
              style: const TextStyle(
                color: Colorer.onBackground,
              ),
            ),
            const SizedBox(height: 5),
            BaseButton(
              text: "Gönder",
              onPressed: () => widget.submit(countryValue, stateValue, cityValue),
            ),
            const SizedBox(
              height: 2.5,
            )
          ],
        ),
      ),
    );
  }
}
