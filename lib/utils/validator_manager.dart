import 'package:email_validator/email_validator.dart';

class ValidatorManager {
  static String? phoneOptionalValidator(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.contains(" ")) {
      return "Boşluk içeremez";
    } else if (value.length != 10) {
      return "Yanlış numara";
    } else if (!containsOnlyNumbers(value)) {
      return "Numara giriniz";
    }
    return null;
  }

  static String? phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Boş bırakılamaz';
    } else if (value.contains(" ")) {
      return "Boşluk içeremez";
    } else if (value.length != 10) {
      return "Yanlış numara";
    } else if (!containsOnlyNumbers(value)) {
      return "Numara giriniz";
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Boş bırakılamaz';
    } else if (!EmailValidator.validate(value)) {
      return "Geçerli email giriniz";
    }
    return null;
  }

  static String? baseValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Boş bırakılamaz';
    }
    return null;
  }

  static String? maxTextValidator(String? value, int max) {
    if (value == null || value.isEmpty) {
      return 'Boş bırakılamaz';
    } else if (value.length > max) {
      return 'Max $max karakter';
    }
    return null;
  }

  static bool containsOnlyNumbers(String str) {
    for (int i = 0; i < str.length; i++) {
      if (int.tryParse(str[i]) == null) return false;
    }
    return true;
  }
}
