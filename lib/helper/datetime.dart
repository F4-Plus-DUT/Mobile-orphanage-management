import 'package:intl/intl.dart';

String commented(String date) {
  DateTime current = DateTime.now();
  DateTime fact = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  if (current.year - fact.year > 0) {
    return (current.year - fact.year).toString() + " năm";
  } else if (current.month - fact.month > 0) {
    return (current.month - fact.month).toString() + " tháng";
  } else if (current.day - fact.day > 0) {
    return (current.day - fact.day).toString() + " ngày";
  } else if (current.hour - fact.hour > 0) {
    return (current.hour - fact.hour).toString() + " giờ";
  } else if (current.minute - fact.minute > 0) {
    return (current.minute - fact.minute).toString() + " phút";
  } else
    return (current.second - fact.second).toString() + " giây";
}
