class Profile {
  late String? id;
  late String? created_at;
  late String? updated_at;
  late String? name;
  late String? address;
  late int? age;
  late String? avatar;
  late String? phone;
  late String? email;
  late String? occupation;

  Profile(
      {this.id,
      this.created_at,
      this.updated_at,
      this.name,
      this.address,
      this.age,
      this.avatar,
      this.phone,
      this.email,
      this.occupation});

  factory Profile.fromJson(Map<String, dynamic> data) {
    return Profile(
        id: data['id'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
        name: data['name'],
        address: data['address'],
        age: data['age'],
        avatar: data['avatar'],
        email: data['email'],
        phone: data['phone'],
        occupation: data['occupation']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['age'] = this.age.toString();
    data['phone'] = this.phone;
    data['occupation'] = this.occupation;
    return data;
  }
}
