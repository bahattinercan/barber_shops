import 'package:intl/intl.dart';

class CustomFormats {
  static DateFormat time = DateFormat('HH:mm dd/MM/yyyy');
  static DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  static DateFormat backendFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
  static DateFormat dayName = DateFormat('EEEE');
  static DateFormat _weekOfTheDay = DateFormat('EEE');

  static String dayOfTheWeek(DateTime dateTime) {
    return _weekOfTheDay.format(dateTime);
  }

  static NumberFormat _IntTo2Letter = NumberFormat("00");
  static String intTo2Letter(int value) {
    return _IntTo2Letter.format(value);
  }
}
