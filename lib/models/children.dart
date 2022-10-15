class Children {
  late String id;
  late String created_at;
  late String? updated_at;
  late bool is_active;
  late String name;
  late int gender;
  late int age;
  late String? personal_picture;
  late String join_date;
  late String status;

  Children(
      {required this.id,
      required this.created_at,
      this.updated_at,
      required this.is_active,
      required this.name,
      required this.gender,
      required this.age,
      required this.personal_picture,
      required this.join_date,
      required this.status});

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
        status: data['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['is_active'] = this.is_active;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['personal_picture'] = this.personal_picture;
    data['join_date'] = this.join_date;
    data['status'] = this.status;
    return data;
  }
}
