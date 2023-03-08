import 'package:intl/intl.dart';

class Formatter {
  static DateFormat time = DateFormat('HH:mm dd/MM/yyyy');
  static DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  static DateFormat backendFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
  static DateFormat dayName = DateFormat('EEEE');
  static final DateFormat _weekOfTheDay = DateFormat('EEE');

  static String dayOfTheWeek(DateTime dateTime) {
    return _weekOfTheDay.format(dateTime);
  }

  static final NumberFormat intFormatter = NumberFormat("00");
  static String intTo2Letter(int value) {
    return intFormatter.format(value);
  }
}
