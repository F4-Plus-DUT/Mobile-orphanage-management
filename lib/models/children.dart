import 'package:uuid_type/uuid_type.dart';

class Children {
  late String id;
  late String created_at;
  late String updated_at;
  late bool is_active;
  late String name;
  late int gender;
  late int age;
  late String personal_picture;
  late String join_date;
  late String status;

  Children(
      {required this.id,
      required this.created_at,
      required this.updated_at,
      required this.is_active,
      required this.name,
      required this.gender,
      required this.age,
      required this.personal_picture,
      required this.join_date,
      required this.status});
}
