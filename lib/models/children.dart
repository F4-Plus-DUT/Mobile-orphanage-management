class Children {
  late String id;
  late String? created_at;
  late String? updated_at;
  late bool is_active;
  late String name;
  late int gender;
  late int age;
  late String? personal_picture;
  late String? join_date;
  late String status;
  late String identifier;

  Children(
      {required this.id,
      this.created_at,
      this.updated_at,
      required this.is_active,
      required this.name,
      required this.gender,
      required this.age,
      this.personal_picture,
      this.join_date,
      required this.status,
      required this.identifier});

  factory Children.fromJson(Map<String, dynamic> data) {
    return Children(
        id: data['id'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
        is_active: data['is_active'],
        name: data['name'],
        gender: data['gender'],
        age: data['age'],
        personal_picture: data['personal_picture'],
        join_date: data['join_date'],
        status: data['status'],
        identifier: data['identifier']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['status'] = this.status;
    data['identifier'] = this.identifier;
    return data;
  }
}
