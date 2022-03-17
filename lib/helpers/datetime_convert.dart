import 'package:intl/intl.dart';

class DatetimeConvert {
  /// dd/MM/yyy -> 21/09/1997
  static String dMy(dynamic date) {
    if (date == null) {
      return '';
    }
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd/MM/yyyy').format(tmp);
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('dd/MM/yyyy').format(tmp);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String hm_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('HH:mm - dd/MM/yyyy').format(tmp);
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('HH:mm - dd/MM/yyyy').format(tmp);
    } else {
      return DateFormat('HH:mm - dd/MM/yyyy').format(date);
    }
  }

  static String dMy_hm(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd/MM/yyyy - HH:mm').format(tmp);
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('dd/MM/yyyy - HH:mm').format(tmp);
    } else {
      return DateFormat('dd/MM/yyyy - HH:mm').format(date);
    }
  }

  /// dd.MM.yyy -> 21.09.1997
  static String dot_dMy(dynamic date) {
    if (date.runtimeType == String) {
      final tmp = DateTime.tryParse(date);
      return DateFormat('dd.MM.yyyy').format(tmp);
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('dd.MM.yyyy').format(tmp);
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }

  /// yyyy-MM-dd -> 1997-09-21
  static String yMd(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('yyyy-MM-dd').format(DateTime.tryParse(date));
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('yyyy-MM-dd').format(tmp);
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  /// MM-dd-yyy -> 09-21-1997
  static String Mdy(dynamic date) {
    if (date.runtimeType == String) {
      return DateFormat('MM-dd-yyyy').format(DateTime.tryParse(date));
    } else if (date.runtimeType == int) {
      var tmp = DateTime.fromMillisecondsSinceEpoch(date);
      return DateFormat('MM-dd-yyyy').format(tmp);
    } else {
      return DateFormat('MM-dd-yyyy').format(date);
    }
  }

  // hh:mm:ss
  static String hms(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;
    return '$hour:$minute:$second';
  }

  // hh:mm:ss
  static String hm(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;
    return '$hour:$minute';
  }

  static String countdown(int seconds) {
    final h = (seconds / 3600).floor();
    final m = ((seconds - h * 3600) / 60).floor();
    final s = seconds - h * 3600 - m * 60;
    if (h == 0) {
      return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
    } else {
      return '${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}';
    }
  }
}
